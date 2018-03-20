class TicketWorker
  include Sidekiq::Worker

  def perform
    session = GoogleDrive::Session.from_service_account_key('config/client_secret.json')
    spreadsheet = session.spreadsheet_by_title('Service Desk')
    worksheet = spreadsheet.worksheets.first
    new_ticket = worksheet.rows.map { |row| row.first(6) }.last
    pre_hash = ['title', 'type_of_ticket', 'responsible_unit', 'detailed_description', 'deadline', 'email'].zip(new_ticket).flatten
    ticket_email = Hash[*pre_hash]
    ticket_params = ticket_email.except(:email)
    user_email = ticket_email.values_at('email').join('')
    user = User.find_by(email: user_email)
    ticket = Ticket.create(ticket_params)
    ticket.user_id = user.id
  end
end
