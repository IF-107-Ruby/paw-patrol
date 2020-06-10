module Admin
  class BaseController < ::ApplicationController
    before_action :authenticate_user!
    layout 'hireo_dashboard'

    breadcrumb 'Dashboard', %i[admin dashboard], match: :exclusive
  end
end
