module Admin
  class DashboardsController < Admin::BaseController
    def index
      authorize(%i[admin dashboard])
      @pagy, @companies = pagy_decorated(Company.all, items: 10)
    end
  end
end
