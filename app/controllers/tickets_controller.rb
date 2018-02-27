class TicketsController < ApplicationController

  def index
    (@filterrific = initialize_filterrific(
      Ticket,
      params[:filterrific],
      select_options: {
        with_type_of_ticket: %w[repaire service_request permisiion_request],
        with_status_of_ticket: %w[newly_created in_progress closed resolved],
        with_responsible_unit: %w[repair service security]
      },
      default_filter_params: {},
      available_filters: %i[with_type_of_ticket with_status_of_ticket with_responsible_unit]
    )) || return

    @tickets = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  rescue ActiveRecord::RecordNotFound => e
    logger.debug("Had to reset filterrific params: #{e.message}")
    redirect_to(reset_filterrific_url(format: :html)) && return
  end

  def new
    @ticket = Ticket.new
  end

  def create
    # @ticket = Ticket.new(ticket_params)
    @ticket = current_user.tickets.new(ticket_params)
re
    if @ticket.save
      redirect_to tickets_path
    else
      render 'new'
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :detailed_description, :type_of_ticket, :author, :executor, :deadline,
                                   :history, :status_of_ticket, :responsible_unit, :avatar)
  end


end
