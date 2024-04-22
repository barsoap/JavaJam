class Users::FollowsController < ApplicationController
  before_action :set_user, only: [:show, :create, :destroy]

  def show
    @follows = @user.followed(@user) # フォローしているユーザー一覧取得
    @followers = User.where(id: @user.follower(@user).pluck(:follow_id)) # フォローされているユーザー一覧取得
  end

  def create
    # フォローレコードが1件もない場合は、レコードを作る
    Follow.find_or_create_by(user_id: params[:user_id], follow_id: current_user.id)
    render 'action'
  end

  def destroy
    # フォローレコードを探し、フォローレコードを削除する
    #   TODO : 勝手に他のユーザーのフォローを外されないようにparams[:id]で対象のユーザーIDを受け取る
    Follow.find_by(user_id: params[:user_id], follow_id: current_user.id).delete
    render 'action'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
