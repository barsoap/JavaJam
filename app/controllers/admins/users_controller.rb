class Admins::UsersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_user_path(@user)
    else
      render :edit
    end
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admins_user_path(@user)
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image, :is_active)
  end

end
