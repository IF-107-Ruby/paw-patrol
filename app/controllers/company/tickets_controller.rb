class Company
  class TicketsController < Company::BaseController
    before_action :read_user_units, only: :new

    def show
      @ticket = policy_scope([:company, Ticket]).find(params[:id]).decorate
    end

    def new
      @ticket = Ticket.new(unit_id: params[:unit_id])
      authorize([:company, @ticket])
    end

    def create
      @ticket = current_user.tickets.build(ticket_params)
      authorize([:company, @ticket])
      if @ticket.save
        flash[:success] = 'Ticket posted!'
        redirect_to [:company, @ticket]
      else
        flash.now[:warning] = 'Ticket is not posted!'
        read_user_units
        render :new
      end
    end

    private

    def read_user_units
      @units = AvailableUserUnitsQuery.new(user: current_user).to_units_array
    end

    def ticket_params
      params.require(:ticket).permit(:name, :unit_id, :description)
    end
  end
end
