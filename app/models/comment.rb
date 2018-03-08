class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :content, length: { minimum: 10, maximum: 100 }, presence: true
end
