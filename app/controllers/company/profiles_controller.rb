class Company
  class ProfilesController < Company::BaseController
    before_action :read_user, only: %i[edit update update_password]

    breadcrumb 'Profile', %i[company profile], match: :exclusive

    def edit; end

    def update
      if @user.update(user_params)
        flash[:success] = 'Profile updated!'
        redirect_to company_profile_path
      else
        flash.now[:warning] = 'Profile is not updated!'
        render :edit
      end
    end

    def update_password
      if @user.update_with_password(user_password_params)
        bypass_sign_in(@user)
        flash[:success] = 'Profile password updated!'
        redirect_to company_profile_path
      else
        flash.now[:warning] = 'Profile password is not updated!'
        render :edit
      end
    end

    private

    def read_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:avatar,
                                   :first_name,
                                   :last_name,
                                   :email)
    end

    def user_password_params
      params.require(:user).permit(:current_password,
                                   :password,
                                   :password_confirmation)
    end
  end
end
