class Company
  class BaseController < ::ApplicationController
    before_action :authenticate_user!
    before_action :check_user_company
    layout 'hireo_dashboard'

    def check_user_company
      redirect_to root_path unless current_user.company?
    end
  end
end
