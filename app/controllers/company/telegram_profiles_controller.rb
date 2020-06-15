class Company
  class TelegramProfilesController < Company::BaseController
    before_action -> { authorize(%i[company telegram_profile]) }

    def create
      telegram_profile = TelegramProfile.find_by(telegram_params)

      if telegram_profile.blank?
        flash[:error] = 'Invalid connection token!'
      else
        telegram_profile.connect_user(current_user)
        flash[:success] = 'Account connected successfully!'
      end

      redirect_back(fallback_location: company_settings_path)
    end

    def destroy
      if current_user.disconnect_telegram_profile
        flash[:success] = 'Account disconnected successfully!'
      else
        flash[:error] = 'Unable to disconnect telegram account!'
      end

      redirect_back(fallback_location: company_settings_path)
    end

    private

    def telegram_params
      params.require(:telegram).permit(:connection_token)
    end
  end
end
