class Company
  class ApiSettingsController < Company::BaseController
    before_action :generate_new_token, only: %i[show]
    def show; end

    def update
      unless current_company.update(company_params)
        flash[:danger] = 'API token permission has not been updated.'
      end
      redirect_to company_api_settings_path
    end

    def regenerate_api_token
      authorize([:company, current_company])
      generate_token
      redirect_to company_api_settings_path
    end

    private

    def generate_new_token
      unless current_company.access_token.nil? && current_company.enable_access_token
        return
      end

      generate_token
    end

    def generate_token
      current_company.update access_token: SecureRandom.hex
    end

    def company_params
      params.require(:company).permit(:enable_access_token)
    end
  end
end
