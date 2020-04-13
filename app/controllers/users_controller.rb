class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show
    get_user
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
    flash[:success] = 'User profile created'
    redirect_to @user 
    else
      render 'new'
    end
  end

  def edit
    @user = get_user
  end

  def update
    if @user.update_attributes(user_params)
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
    params.require(:user).permit(:first_name, :last_name, :email, :is_admin)
  end
  def get_user
    @user = User.find(params[:id])
  end
  
  
  
end
