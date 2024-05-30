class Users::RecipeCommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    # if recipe.nil?
      # redirect_to recipes_path
      # return
    # end
    comment = current_user.recipe_comments.new(recipe_comment_params)
    comment.recipe_id = @recipe.id
    comment.save

    render 'action'
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    recipe_comment = @recipe.recipe_comments.find(params[:id])
    recipe_comment.destroy if recipe_comment.user == current_user

    render 'action'
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:contents, :user_id)
  end
end
