# Ticket model
class Ticket < ApplicationRecord
  after_create :send_create_telegram_message
  after_update :send_update_telegram_message
  after_destroy :send_destroy_telegram_message

  belongs_to :user, foreign_key: 'user_id'
  has_paper_trail
  has_many :comments, dependent: :destroy

  enum type_of_ticket: %i[repaire service_request permisiion_request]
  enum status_of_ticket: %i[newly_created in_progress closed resolved]
  enum responsible_unit: %i[repair service security]
  enum priority: %i[low middle high]

  validates :title, length: { minimum: 10, maximum: 100 }, presence: true, uniqueness: true
  validates :detailed_description, length: { minimum: 20, maximum: 1000 }
  validates :deadline, :type_of_ticket, :responsible_unit, :priority, presence: true

  mount_uploader :attachment, AttachmentUploader

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: %w[
      sorted_by
      search_query
      with_type_of_ticket
      with_status_of_ticket
      with_responsible_unit
      with_priority
      with_user_id
      with_created_at_gte
    ]
  )

  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(tickets.title) LIKE ?",
          "LOWER(tickets.detailed_description) LIKE ?",
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )

  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("tickets.created_at #{ direction }")
    when /^updated_at_/
        order("tickets.updated_at #{ direction }")
    when /^title_/
      order("LOWER(tickets.title) #{ direction }")
    when /^deadline_/
        order("tickets.deadline #{ direction }")
    when /^type_of_ticket_/
        order("tickets.type_of_ticket #{ direction }")
    when /^status_of_ticket_/
        order("tickets.status_of_ticket #{ direction }")
    when /^responsible_unit_/
        order("tickets.responsible_unit #{ direction }")
    when /^priority_/
        order("tickets.priority #{ direction }")
    when /^author_/
      order("LOWER(users.username) #{ direction }").includes(:user).references(:user)
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_type_of_ticket, lambda { |type_of_tickets|
    return nil if type_of_tickets == ['']
    where(type_of_ticket: [*type_of_tickets])
  }

  scope :with_status_of_ticket, lambda { |status_of_tickets|
    return nil if status_of_tickets == ['']
    where(status_of_ticket: [*status_of_tickets])
  }

  scope :with_responsible_unit, lambda { |responsible_units|
    return nil if responsible_units == ['']
    where(responsible_unit: [*responsible_units])
  }
  
  scope :with_priority, lambda { |priority|
    return nil if priority == ['']
    where(priority: [*priority])
  }

  scope :with_user_id, lambda { |user_ids|
    return nil if user_ids == ['']
    where(:user_id => [*user_ids])
  }
  scope :with_created_at_gte, lambda { |ref_date|
    return nil if created_at_gtes == ['']
    where('tickets.created_at >= ?', ref_date)
  }

  delegate :username, :to => :user, :prefix => true

  def self.options_for_sorted_by
    [
      ['Title (a-z)', 'title_asc'],
      ['Title (z-a)', 'title_desc'],
      ['Creation date (newest first)', 'created_at_desc'],
      ['Creation date (oldest first)', 'created_at_asc'],
      ['Author (a-z)', 'author_asc'],
      ['Author (z-a)', 'author_desc']

    ]
  end

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end

  private

   def ticket_author
     user = User.find_by(id: user_id)
     user.username
   end

   def send_create_telegram_message
     TelegramBotJob.new.perform_async_create(id, title, ticket_author)
   end

   def send_update_telegram_message
     TelegramBotJob.new.perform_async_update(id, title, ticket_author)
   end

   def send_destroy_telegram_message
     TelegramBotJob.new.perform_async_destroy(id, title, ticket_author)
   end

end
