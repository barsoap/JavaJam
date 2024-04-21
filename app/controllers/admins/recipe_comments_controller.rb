class Admins::RecipeCommentsController < ApplicationController
  def destroy
    RecipeComment.find(params[:id]).destroy
    redirect_to admins_recipe_path(params[:recipe_id])
  end
end
