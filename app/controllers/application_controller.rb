# Main controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  before_action :authenticate_user!

  before_action :set_paper_trail_whodunnit

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def initialize_current_user
    User.current = current_user
  end
end
