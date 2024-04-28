class Users::RecipeBookmarksController < ApplicationController
  before_action :set_recipe, only: [:create, :destroy]

  def index
    @bookmarks = current_user.recipe_bookmarks
  end

  def create
    RecipeBookmark.create(user_id: current_user.id, recipe_id: params[:recipe_id])
    render 'action'
  end

  def destroy
    RecipeBookmark.find_by(user_id: current_user.id, recipe_id: params[:recipe_id]).destroy
    render 'action'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
