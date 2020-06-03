class Company
  class DashboardsController < Company::BaseController
    EMPLOYEE = 'employee'.freeze
    STAFF_MEMBER = 'staff_member'.freeze
    COMPANY_OWNER = 'company_owner'.freeze

    def show
      case current_user.role
      when EMPLOYEE, STAFF_MEMBER
        load_worker_data
      when COMPANY_OWNER
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
