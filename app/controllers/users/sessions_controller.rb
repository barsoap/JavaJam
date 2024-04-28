# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  #ゲストログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "guestuserでログインしました。"
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
