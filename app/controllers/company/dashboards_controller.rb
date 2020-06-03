class Company
  class DashboardsController < Company::BaseController
    def show
      if current_user.staff_member? || current_user.employee?
        load_worker_data
      elsif current_user.company_owner?
        @company_statistics = [{ subtitle: 'Workers',
                                 value: current_company.employees.count },
                               { subtitle: 'Responsible users',
                                 value: current_company.responsible_users.count }]
      end
    end

    private

    def load_worker_data
      @current_tickets = current_user.current_tickets
                                     .most_recent
                                     .decorate
                                     .take(7)
      @resolved_tickets = current_user.resolved_tickets
                                      .most_recent
                                      .decorate
                                      .take(7)
    end
  end
end
