class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :read_units, only: :new

  def show
    @ticket = Ticket.find(params[:id]).decorate
  end

  def new
    @ticket = Ticket.new
    authorize @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    authorize @ticket
    if @ticket.save
      flash[:success] = 'Ticket saved!'
      redirect_to @ticket
    else
      flash.now[:warning] = 'Ticket is not saved!'
      read_units
      render :new
    end
  end

  private

  def read_units
    @units = AvailableUserUnitsFindQuery.new(user: current_user).to_units_array
  end

  def ticket_params
    params.require(:ticket)
          .permit(:name, :unit_id, :description)
          .merge!(user_id: current_user.id)
  end
end
