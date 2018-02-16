# TicketsController
class TicketsController < ApplicationController

  def index
    @tickets = Ticket.all
  end

  def ticket_params
    params.require(:ticket).permit(:title, :detailed_description, :type_of_ticket,
                                   :status_of_ticket, :responsible_unit)
  end

end
