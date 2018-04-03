class TicketJob < ApplicationJob
  queue_as :default

  def perform
    session = GoogleDrive::Session.from_service_account_key('config/client_secret.json')
    spreadsheet = session.spreadsheet_by_title('Service Desk')
    worksheet = spreadsheet.worksheets.first
    @new_ticket = worksheet.rows.map { |row| row.first(6) }.last
    user_and_ticket_data
  end

  private

  def user_and_ticket_data
    pre_hash = %w[title type_of_ticket responsible_unit detailed_description deadline email].zip(@new_ticket).flatten
    @ticket_email = Hash[*pre_hash]
    user_email = @ticket_email.values_at('email').join('')
    user = User.find_by(email: user_email)
    @user_id = { user_id: user.id, status_of_ticket: 'newly_created' }
    ticket_create
  end

  def ticket_create
    ticket_params = @ticket_email.except('email').merge(@user_id)
    Ticket.create(ticket_params)
  end
end
