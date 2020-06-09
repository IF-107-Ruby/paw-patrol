class Company
  class DashboardsController < Company::BaseController
    def satisfaction
      @satisfaction = ReadSatisfaction.call(current_company)
      render json: @satisfaction
    end
  end
end
