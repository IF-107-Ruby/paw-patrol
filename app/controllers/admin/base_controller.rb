module Admin
  class BaseController < ::ApplicationController
    before_action :authenticate_user!
    layout 'hireo_dashboard'
  end
end
