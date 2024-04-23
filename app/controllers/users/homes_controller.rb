class Users::HomesController < ApplicationController
  def top
    @recipes = Recipe.order(created_at: :desc)
  end
end
