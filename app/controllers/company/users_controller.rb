class Company
  class UsersController < Company::BaseController
    before_action :obtain_user, only: %i[show edit update destroy]

    def index
      authorize([:company, User])
      @pagy, @users = pagy_decorated(users_base_relation, items: 10)
    end

    def show; end

    def new
      _, @user = authorize([:company, users_base_relation.build])
    end

    def create
      _, @user = authorize([:company, users_base_relation.build(user_params)])
      if @user.save
        flash[:success] = 'Company member created.'
        redirect_to company_users_path
      else
        render 'new'
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:success] = 'User profile updated'
        redirect_to [:company, @user]
      else
        render 'edit'
      end
    end

    def destroy
      @user.destroy
      flash[:success] = 'Company member was deleted'
      redirect_to company_users_path
    end

    private

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :role)
    end

    def obtain_user
      _, @user = authorize([:company, users_base_relation.find(params[:id]).decorate])
    end

    def users_base_relation
      current_company.users
    end
  end
end
