class Company
  class TelegramProfilesController < Company::BaseController
    def create
      telegram_profile = TelegramProfile.find_by(telegram_params)
      if telegram_profile.blank?
        flash[:error] = 'Invalid link token'
      else
        telegram_profile.connect_user(current_user)
        NotifyTelegramConnectJob.perform_later(telegram_profile.id)
        flash[:success] = 'Account connected successfully!'
      end
      redirect_back(fallback_location: company_settings_path)
    end

    def destroy
      telegram_profile = current_user.telegram_profile
      if telegram_profile.disconnect_user
        flash[:success] = 'Account disconnected successfully!'

        NotifyTelegramDisconnectJob.perform_later(telegram_profile.id)
      else
        flash[:error] = 'Unable to disconnect telegram account'
      end

      redirect_back(fallback_location: company_settings_path)
    end

    private

    def telegram_params
      params.require(:telegram).permit(:link_token)
    end
  end
end
