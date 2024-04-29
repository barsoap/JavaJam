class Users::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :is_matching_login_user, only: [:withdrow, :edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find_by(id: params[:id], is_active: true)
    redirect_to root_path, alert: '存在しないユーザーです' and return if @user.nil?
    @recipes = Recipe.where(user_id: @user)
    @equipments = Equipment.where(user_id: @user)
    @notes = Note.where(user_id: @user)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image, :is_active)
  end


  #アクセス制限
  def is_matching_login_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to user_path
    end
  end

  #ゲストユーザー用
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
