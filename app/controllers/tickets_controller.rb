class TicketsController < ApplicationController
  before_action :authenticate_user!

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash[:success] = 'Ticket saved!'
      redirect_to @ticket
    else
      flash.now[:warning] = 'Ticket is not saved!'
      render :new
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :description).merge!(user_id: current_user.id)
  end
end
