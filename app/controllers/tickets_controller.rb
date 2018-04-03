class TicketsController < ApplicationController
  before_action :find_ticket, only: %i[show edit update destroy]
  before_action :owned_ticket, only: %i[edit update destroy]
  before_action :ticket, only: :new

  def index
    (@filterrific = initialize_filterrific(
      Ticket,
      params[:filterrific],
      select_options: {
        sorted_by: Ticket.options_for_sorted_by,
        with_type_of_ticket: %w[repaire service_request permisiion_request],
        with_status_of_ticket: %w[newly_created in_progress closed resolved],
        with_responsible_unit: %w[repair service security],
        with_user_id: User.options_for_select
      },
      default_filter_params: {},
      available_filters: %i[sorted_by search_query with_type_of_ticket with_status_of_ticket with_responsible_unit with_user_id]
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

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new; end

  def create
    @ticket = current_user.tickets.new(ticket_params)
    @ticket.status_of_ticket = :newly_created

    if @ticket.save
      UserMailer.ticket_email(@current_user).deliver
      flash[:success] = 'Ticket created'
      redirect_to tickets_path
    else
      flash[:warning] = 'Ticket not created'
      render :new
    end
  end

  def edit; end

  def update
    if @ticket.update(ticket_params)
      flash[:success] = 'Ticket updated'
      redirect_to tickets_path
    else
      flash[:warning] = 'Ticket not updated'
      render 'edit'
    end
  end

  def destroy
    if @ticket.destroy
      flash[:success] = 'Ticket deleted'
      redirect_to tickets_path
    else
      flash[:warning] = "Ticket doesn't exist"
    end
  end

  private

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :detailed_description, :type_of_ticket, :executor, :deadline,
                                   :history, :status_of_ticket, :responsible_unit, :attachment)
  end

  def ticket
    @ticket ||= Ticket.new
  end

  def owned_ticket
    if current_user.id != @ticket.user_id
      flash[:alert] = "That ticket doesn't belong to you!"
      redirect_to root_path
    end
  end
end
