class Users::RecipeCommentsController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    # if recipe.nil?
      # redirect_to recipes_path
      # return
    # end
    comment = current_user.recipe_comments.new(recipe_comment_params)
    comment.recipe_id = recipe.id
    if comment.save
      redirect_to recipe_path(recipe.id)
    else
      render :recipes/index
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path
  end

  def destroy
    RecipeComment.find(params[:id]).destroy
    redirect_to recipe_path(prams[:recipe_id])
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:contents, :user_id)
  end
end
