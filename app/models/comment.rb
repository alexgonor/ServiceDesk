class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :content, length: { maximum: 100 }, presence: true
end
