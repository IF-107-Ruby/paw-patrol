class TicketCompletionsController < ApplicationController
  before_action :read_ticket

  def create
    if current_user.create_ticket_completion(ticket_completion_params
      .merge(ticket: @ticket))
      flash[:success] = 'Ticket resolved!'
    else
      flash.now[:warning] = 'Ticket is not resolved!'
    end
    redirect_to @ticket
  end

  def edit; end

  def destroy; end

  private

  def read_ticket
    @ticket = Ticket.find_by(id: params[:ticket_id]).decorate
  end

  def ticket_completion_params
    params.require(:ticket_completion).permit(:description)
  end
end
