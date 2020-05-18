class Company
  class BaseController < ::ApplicationController
    before_action :authenticate_user!
    before_action :check_user_company
    layout 'hireo_dashboard'

    breadcrumb -> { current_company.name }, :company_path, match: :exclusive

    private

    def check_user_company
      redirect_to root_path unless current_user.company?
    end

    def add_pagy_headers
      pagy_headers_merge(@pagy) if @pagy
    end
  end
end
