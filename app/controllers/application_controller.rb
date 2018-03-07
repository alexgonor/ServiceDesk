# Main controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def initialize_current_user
    User.current = current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation,
               :remember_me, :avatar, :avatar_cache)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:username, :password, :password_confirmation,
               :current_password, :avatar, :avatar_cache,
               :remove_avatar)
    end
  end
end
