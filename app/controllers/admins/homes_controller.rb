class Admins::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
    @users = User.all
  end
end
