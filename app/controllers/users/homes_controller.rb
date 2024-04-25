class Users::HomesController < ApplicationController
  def top
    @recipes = Recipe.find(RecipeBookmark.group(:recipe_id).order('count(recipe_id) desc').pluck(:recipe_id).take(6))
  end
end