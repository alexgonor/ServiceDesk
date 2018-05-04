# User devise model
class User < ApplicationRecord

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  enum type_of_user: %i[user executor]

  has_many :tickets
  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :identity

   #User Avatar Validation
  validates_presence_of :avatar
  validates_presence_of :position_in_the_company
  validates_presence_of :username
  validates_presence_of :type_of_user

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:twitter, :google_oauth2]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update


  def self.find_for_oauth(auth, signed_in_resource = nil)

    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    if user.nil?
      email_is_verified = auth.info.email.present?
      email = auth.info.email if email_is_verified
      user = User.find_by(email: email) if email

      if user.nil?
        password = Devise.friendly_token[0,20]
        user = User.new(
          username: auth.info.name || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: password,
          remote_avatar_url: auth.info.image,
          position_in_the_company: set_company_position(identity),
          type_of_user: 0
        )
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def self.set_company_position(identity)
     identity.provider == "twitter" ? "twitter_user" : "google_user"
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def self.options_for_select
    order('LOWER(username)').map { |e| [e.username, e.id] }
  end

  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end

end

