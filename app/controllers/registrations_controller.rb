# Controller for update user params
class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :position_in_the_company,
                                 :type_of_user, :username, :avatar)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :current_password, :position_in_the_company,
                                 :type_of_user, :username, :avatar, :remove_avatar)
  end
end
