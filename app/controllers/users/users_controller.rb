class Users::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit_user_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :is_active)
  end

end
