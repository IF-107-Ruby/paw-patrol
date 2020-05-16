class Company
  class WatchersController < Company::BaseController
    def update
      @ticket = Ticket.find(params[:ticket_id])
      @ticket.update(watcher_relationship_params)
      flash[:success] = 'Watchers updated!'
      redirect_to company_ticket_path(@ticket)
    end

    private

    def watcher_relationship_params
      params
        .require(:ticket)
        .permit(:id, watcher_ids: [])
    end
  end
end
