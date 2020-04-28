class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user, only: %i[show edit update destroy]
  before_action :current_company

  def index
    @pagy, @users = pagy_decorated(authorize(User.all), items: 10)
  end

  def show; end

  def new
    @user = authorize(@current_company.members.build)
  end

  def create
    @user = @current_company.users.create(user_params)
    @user.role = user_role_param[:role].to_i
    if @user.save
      flash[:success] = 'Company member created.'
      redirect_to company_members_path(@current_company)
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
                                 :password_confirmation)
  end

  def obtain_user
    @user = authorize(User.find(params[:id]).decorate)
  end

  def user_role_param
    params.require(:user).permit(:role)
  end
end
