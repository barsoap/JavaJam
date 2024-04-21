class Admins::RecipesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @recipes = Recipe.all.page(params[:page]).per(10)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to admins_recipes_path
  end
end
