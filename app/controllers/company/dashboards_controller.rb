class Company
  class DashboardsController < Company::BaseController
    def show
      send("load_#{current_user.role}_dashboard_data")
    end

    def load_employee_dashboard_data
      @current_pagy, @current_tickets = pagy_decorated(
        current_user.current_tickets.most_recent,
        items: 5,
        page_param: :page_current_tickets
      )

      @resolved_pagy, @resolved_tickets = pagy_decorated(
        current_user.resolved_tickets.most_recent,
        items: 5,
        page_param: :page_resolved_tickets
      )
    end

    def load_staff_member_dashboard_data; end

    def load_company_owner_dashboard_data; end
  end
end
