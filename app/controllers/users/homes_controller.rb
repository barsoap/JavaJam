class Users::HomesController < ApplicationController
  def top
    @recipes = Recipe.find(RecipeBookmark.group(:recipe_id).order('count(recipe_id) desc').pluck(:recipe_id).take(6))
    @bm_recipes = Recipe.where(user_id: current_user.followed(current_user).pluck(:user_id)).order(created_at: :desc).take(3) if user_signed_in?
    @follows = current_user.followed(current_user).is_active if user_signed_in? #.where(is_active: true) # フォローしているユーザー一覧取得
    # @users = User
    #   .select('users.*, COUNT(follows.id) AS followers_count')
    #   .joins(:follower_relationships)
    #   .group('users.id')
    #   .order('followers_count DESC')
    #   .limit(4)
    @users = User.order(created_at: :desc).where.not(email: 'guest@example.com').limit(4)
  end

  private
    # フォローしている一覧取得
    def followed(user)
      Follow.where(follow_id: user.id)
    end

end

