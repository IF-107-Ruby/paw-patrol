module Admin
  class DashboardsController < Admin::BaseController
    def index
      authorize(%i[admin dashboard])
    end
  end
end
