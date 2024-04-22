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
    @user = User.find(params[:user_id])
    @user.update(is_active: !@user.is_active)
    session.delete(@user) if @user.is_active == false
    status = @user.is_active ? '復元' : '退会'
    redirect_to admins_user_path(@user), notice: "#{status}処理を実行いたしました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image, :is_active)
  end
end
