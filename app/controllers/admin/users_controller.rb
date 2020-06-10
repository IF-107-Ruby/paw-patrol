module Admin
  class UsersController < Admin::BaseController
    before_action :obtain_user, only: %i[show edit update destroy impersonate]

    breadcrumb 'Users', %i[admin users], match: :exclusive
    breadcrumb -> { @user.full_name }, -> { [:admin, @user] },
               match: :exclusive, only: %i[show edit update]
    breadcrumb 'Edit', [:edit, :admin, :user, @user], only: %i[edit update]

    def index
      authorize([:admin, User])
      @pagy, @users = pagy_decorated(User.all, items: 10)
    end

    def show; end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:success] = 'User profile updated'
        redirect_to admin_user_path
      else
        render 'edit'
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path
    end

    def impersonate
      impersonate_user(@user)
      flash[:success] = "You are signed in as #{current_user.full_name}"
      redirect_to current_user.after_sign_in_path
    end

    def stop_impersonating
      stop_impersonating_user
      flash[:success] = 'You returned to your admin profile'
      redirect_to current_user.after_sign_in_path
    end

    private

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end

    def obtain_user
      _, @user = authorize([:admin, User.find(params[:id]).decorate])
    end
  end
end
