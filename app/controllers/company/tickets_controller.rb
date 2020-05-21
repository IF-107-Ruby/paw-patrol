class Company
  class TicketsController < Company::BaseController
    before_action :read_user_units, only: :new

    def show
      @ticket = policy_scope([:company, Ticket]).find(params[:id]).decorate
      Notification.mark_comments_as_read(@ticket, current_user)
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

<<<<<<< HEAD
    def resolved
      authorize([:company, Ticket])
      @pagy, @resolved_tickets = pagy_decorated(current_user
                                                    .tickets
                                                    .resolved
                                                    .most_recent,
                                                items: 10)
=======
    def resolution
      @ticket = policy_scope([:company, Ticket]).find(params[:ticket_id])

      @ticket.update(ticket_resolution_params) if check_resolution_presence

      @ticket.complete_and_save!
      flash[:success] = 'Ticket resolved!'
      redirect_to [:company, @ticket]
>>>>>>> changed creation ticket resolution way.
    end

    private

    def read_user_units
      @units = AvailableUserUnitsQuery.new(user: current_user).to_units_array
    end

    def ticket_params
      params.require(:ticket).permit(:name, :unit_id, :description)
    end

    def ticket_resolution_params
      params.require(:ticket).permit(:resolution)
    end

    def check_resolution_presence
      params[:ticket][:resolution] != ''
    end
  end
end
