class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :read_units, only: %i[new create]

  def show
    @ticket = Ticket.find(params[:id]).decorate
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

  def read_units
    # TODO
    @units = Company.first.units
  end

  def ticket_params
    params.require(:ticket)
          .permit(:name, :unit_id, :description)
          .merge!(user_id: current_user.id)
  end
end
