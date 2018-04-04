class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def ticket_email(user)
    @current_user = user
    mail to: user.email, subject: 'Welcome to Service Desk'
  end

  def take_in_work_email(user, ticket)
    @user = user
    @ticket = ticket
    mail to: user.email, subject: 'Your ticket was taken to work'
  end

  def resolved_email(user, ticket)
    @user = user
    @ticket = ticket
    mail to: user.email, subject: 'Your ticket was resolved'
  end

  def closed_email(executor, ticket)
    @executor = executor
    @ticket = ticket
    mail to: executor.email, subject: 'The ticket you worked on was closed'
  end

  def google_form_ticket(user, ticket)
    @user = user
    @ticket = ticket
    mail to: user, subject: 'Your ticket has been saved'
  end
end
