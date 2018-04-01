# Ticket model
class Ticket < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy

  enum type_of_ticket: %i[repaire service_request permisiion_request]
  enum status_of_ticket: %i[newly_created in_progress closed resolved]
  enum responsible_unit: %i[repair service security]

  validates :title, length: { minimum: 10, maximum: 100 }, presence: true, uniqueness: true
  validates :detailed_description, length: { minimum: 20, maximum: 200 }
  validates :deadline, :type_of_ticket, :responsible_unit, presence: true

  mount_uploader :attachment, AttachmentUploader

  filterrific(
    available_filters: %i[
      with_type_of_ticket
      with_status_of_ticket
      with_responsible_unit
    ]
  )
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

end
