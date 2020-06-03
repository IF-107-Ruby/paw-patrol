class Company
  class DashboardsController < Company::BaseController
    EMPLOYEE = 'employee'
    STAFF_MEMBER = 'staff_member'
    COMPANY_OWNER = 'company_owner'

    def show
      case current_user.role
      when EMPLOYEE, STAFF_MEMBER
        @current_tickets = current_user.current_tickets
                                       .most_recent
                                       .decorate
                                       .take(5)
        @resolved_tickets = current_user.resolved_tickets
                                        .most_recent
                                        .decorate
                                        .take(5)

      when COMPANY_OWNER

      end
    end
  end
end
