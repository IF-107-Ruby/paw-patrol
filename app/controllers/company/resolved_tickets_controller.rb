class Company
  class ResolvedTicketsController < Company::BaseController
    def index
      authorize([:company, Ticket])
      @pagy, @resolved_tickets = pagy_decorated(current_user.tickets.were_resolved,
                                                items: 10)
    end
  end
end
