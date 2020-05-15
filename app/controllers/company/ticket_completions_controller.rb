class Company
  class TicketCompletionsController < Company::BaseController
    before_action :read_ticket

    def create
      @ticket_completion = @ticket.build_ticket_completion(ticket_completion_params)
      authorize([:company, @ticket_completion])

      if @ticket_completion.save
        @ticket.complete_and_save!
        flash[:success] = 'Ticket resolved!'
        redirect_to [:company, @ticket]
      else
        flash.now[:warning] = 'Ticket is not resolved!'
        render template: 'company/tickets/show'
      end
    end

    private

    def read_ticket
      @ticket = Ticket.find_by(id: params[:ticket_id]).decorate
    end

    def ticket_completion_params
      params
        .require(:ticket_completion)
        .permit(:description)
        .merge(user_id: current_user.id)
    end
  end
end
