class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user, only: %i[show edit update destroy]

  def index
    @pagy, @users = pagy_decorated(authorize(User.all), items: 10)
  end

  def show; end

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
end
