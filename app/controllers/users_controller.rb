class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user, only: %i[show edit update destroy]

  def index
    @pagy, @company_users = pagy_decorated(authorize(users_base_relation), items: 10)
  end

  def show; end

  def new
    @user = authorize(users_base_relation.build)
  end

  def create
    @user = authorize(users_base_relation.build(user_params))
    @password = @user.password
    if @user.save
      flash[:success] = 'Company member created.'
      redirect_to users_path
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
    flash[:success] = "User profile \"#{@user.full_name}\" was deleted!"
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
    current_company.members
  end
end
