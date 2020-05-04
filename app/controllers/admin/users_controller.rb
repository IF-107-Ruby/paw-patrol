class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user, only: %i[show edit update destroy impersonate]

  def index
    @pagy, @users = pagy_decorated(User.all, items: 10)
  end   

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User profile created'
      redirect_to admin_user_path(@user)
    else
      render 'new'
    end
  end

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
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    flash[:success] = "You returned to your admin profile"
    redirect_to root_path
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
    @user = User.find(params[:id]).decorate
  end
end
