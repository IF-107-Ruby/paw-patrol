class Company
  class AccessTokensController < Company::BaseController
    def create
      if current_user.update(access_token: generate_access_token,
                             access_token_enabled: true)
        flash[:success] = 'New API access token added successfully.'
      else
        flash[:error] = 'Unable to add API access token.'
      end

      redirect_back(fallback_location: company_settings_path)
    end

    def update
      if current_user.update(user_params)
        flash[:success] = 'Api token permission updated.'
      else
        flash[:error] = 'API token permission has not been updated.'
      end

      redirect_back(fallback_location: company_settings_path)
    end

    def destroy
      if current_user.update(access_token: nil,
                             access_token_enabled: nil)
        flash[:success] = 'API access token removed successfully.'
      else
        flash[:error] = 'Unable to remove API access token.'
      end

      redirect_back(fallback_location: company_settings_path)
    end

    private

    def user_params
      params.require(:user).permit(:access_token_enabled)
    end

    def generate_access_token
      loop do
        token = SecureRandom.urlsafe_base64
        break token unless User.exists?({ access_token: token })
      end
    end
  end
end
