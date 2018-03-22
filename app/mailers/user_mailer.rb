class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def ticket_email(user)
    @current_user = user
    mail to: user.email, subject: 'Welcome to Service Desk'
  end
end
