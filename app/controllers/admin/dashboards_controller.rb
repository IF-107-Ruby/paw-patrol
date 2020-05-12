module Admin
  class DashboardsController < Admin::BaseController
    before_action :authenticate_user!

    def index
      authorize(%i[admin dashboard])
    end
  end
end
