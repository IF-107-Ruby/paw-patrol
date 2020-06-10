class Company
  class TelegramAccountsController < Company::BaseController
    def create
      telegram_user = TelegramUser.find_by({ link_token: telegram_params[:link_token] })
      if telegram_user.blank?
        flash[:error] = 'Invalid link token'
      else
        telegram_user.connect_user(current_user)
        flash[:success] = 'Account connected successfully!'
      end
      redirect_back(fallback_location: company_units_path)
    end

    def destroy
      current_user.telegram_user.disconect_user
    end

    private

    def telegram_params
      params.require(:telegram).permit(:link_token)
    end
  end
end
