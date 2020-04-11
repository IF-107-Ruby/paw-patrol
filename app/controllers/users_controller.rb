class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    redirect_to @user if @user.save
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'User profile updated'
      redirect_to @user
    else
      render 'edit'
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to @users
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :is_admin)
  end
  
  
  
end
