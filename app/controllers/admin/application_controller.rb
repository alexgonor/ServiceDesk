class Admin::ApplicationController < ActionController::Base
  http_basic_authenticate_with name: 'admin', password: 'admin'

  before_action :require_admin

  layout 'admin/application'
  
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end


  private

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
