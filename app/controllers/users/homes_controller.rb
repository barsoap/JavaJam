class Users::HomesController < ApplicationController
  def top
    @recipes = Recipe.find(RecipeBookmark.group(:recipe_id).order('count(recipe_id) desc').pluck(:recipe_id).take(6))
    @bm_recipes = Recipe.where(user_id: current_user.followed(current_user).pluck(:user_id)).order(created_at: :desc).take(3) if user_signed_in?
  end

  private
    # フォローしている一覧取得
    def followed(user)
      Follow.where(follow_id: user.id)
    end

end

