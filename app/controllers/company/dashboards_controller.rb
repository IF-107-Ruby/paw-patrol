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

    def satisfaction
      @satisfaction = ReadSatisfaction.call(current_company)
      render json: @satisfaction
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
