class Users::RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    if @recipe.save(recipe_params)
      redirect_to recipee_path
    else
      render :edit
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:user_id, :title, :contents, :evaluation)
  end

end