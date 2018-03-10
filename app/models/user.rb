# User devise model
class User < ApplicationRecord
  has_many :tickets
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum type_of_user: %i[user executor]

  validates :position_in_the_company, presence: true
  validates :type_of_user, presence: true
end
