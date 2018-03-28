# User devise model
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :tickets
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum type_of_user: %i[user executor]

  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  def self.options_for_select
    order('LOWER(username)').map { |e| [e.username, e.id] }
  end

  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end

  validates :position_in_the_company, presence: true
  validates :username, presence: true
  validates :type_of_user, presence: true
  
end
