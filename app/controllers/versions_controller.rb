class VersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket_and_version, only: [:diff, :destroy]

  def diff
  end

  private

  def set_ticket_and_version
    @ticket = Ticket.find(params[:ticket_id])
    @version = @ticket.versions.find(params[:id])
  end
end
