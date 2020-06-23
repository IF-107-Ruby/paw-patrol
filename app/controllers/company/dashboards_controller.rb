class Company
  class DashboardsController < Company::BaseController
    breadcrumb 'Dashboard', :company_dashboard_path

    def show
      load_worker_data if current_user.staff_member? || current_user.employee?
    end

    private

    def load_worker_data
      @current_tickets = current_user.current_tickets
                                     .most_recent
                                     .limit(7)
                                     .decorate
      @resolved_tickets = current_user.resolved_tickets
                                      .most_recent
                                      .limit(7)
                                      .decorate
    end
  end
end
