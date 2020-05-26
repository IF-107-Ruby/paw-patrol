class Company
  class TicketsController < Company::BaseController
    before_action :read_user_units, only: %i[new followed_new]
    before_action :read_ticket, only: %i[resolution followed_new]

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

    def resolved
      authorize([:company, Ticket])
      @pagy, @resolved_tickets = pagy_decorated(current_user
                                                    .tickets
                                                    .resolved
                                                    .most_recent,
                                                items: 10)
    end

    def resolution
      @ticket = policy_scope([:company, Ticket]).find(params[:ticket_id]).decorate

      if @ticket.complete!(ticket_resolution_params)
        flash[:success] = 'Ticket resolved!'
        redirect_to [:company, @ticket]
      else
        flash[:warning] = 'Ticket is resolved!'
        render :show
      end
    end

    def followed_new
      @followed_ticket = policy_scope([:company, Ticket]).find(params[:ticket_id]).clone
      @ticket = @followed_ticket.dup
      @ticket.description = @followed_ticket.description
    end

    private

    def read_user_units
      @units = AvailableUserUnitsQuery.new(user: current_user).to_units_array
    end

    def ticket_params
      params.require(:ticket).permit(:name, :unit_id, :description, :parent_id)
    end

    def ticket_resolution_params
      params.require(:ticket).permit(:resolution)
    end

    def read_ticket
      @ticket = policy_scope([:company, Ticket]).find(params[:ticket_id]).decorate
    end
  end
end
