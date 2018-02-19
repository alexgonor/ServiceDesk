# class Ticket < ApplicationRecord
# end
class Ticket < ApplicationRecord
  #  belongs_to :user
  enum type_of_ticket: %i[repaire service_request permisiion_request]
  enum status_of_ticket: %i[newly_created in_progress closed resolved]
  enum responsible_unit: %i[repair service security]
  validates :title, length: { minimum: 10, maximum: 100 }, presence: true, uniqueness: true
  validates :detailed_description, length: { minimum: 20, maximum: 200 }
  validates :deadline, presence: true
  validates :author, presence: true
end
