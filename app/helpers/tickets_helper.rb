module TicketsHelper
  def ticket_of_current_user?(ticket)
    ticket.user_id == current_user.id
  end
end
