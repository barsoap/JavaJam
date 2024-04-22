class Admins::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
    @users = User.page(params[:page]).per(10)
  end
end
