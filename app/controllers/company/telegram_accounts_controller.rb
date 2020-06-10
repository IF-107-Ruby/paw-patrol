class Company
  class TelegramAccountsController < Company::BaseController
    def create
      telegram_user = TelegramUser.find_by({ link_token: telegram_params[:link_token] })
      if telegram_user.blank?
        flash[:error] = 'Invalid link token'
      else
        telegram_user.connect_user(current_user)
        NotifyTelegramConnectJob.perform_later(telegram_user.id)
        flash[:success] = 'Account connected successfully!'
      end
      redirect_back(fallback_location: company_settings_path)
    end

    def destroy
      telegram_user = current_user.telegram_user
      if telegram_user.disconnect_user
        flash[:success] = 'Account disconnected successfully!'

        NotifyTelegramDisconnectJob.perform_later(telegram_user.id)
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
