class Admins::RecipeCommentsController < ApplicationController
  def destroy
    comment = RecipeComment.find()
    comment.destroy
    redirect_to admins_recipe_path(:recipe_id)
  end
end
