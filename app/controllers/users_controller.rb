class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user, only: %i[show edit update destroy]

  def index
    @pagy, @company_users = pagy_decorated(authorize(current_company.users), items: 10)
  end

  def show; end

  def new
    @user = authorize(current_company.users.build)
  end

  def create
    @user = authorize(current_company.users.build(user_params))
    if @user.save
      flash[:success] = 'Company member created.'
      redirect_to users_path(current_company)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'User profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to [:users]
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
    @user = authorize(users_base_relation.find(params[:id]).decorate)
  end

  def users_base_relation
    current_company.users
  end
end
