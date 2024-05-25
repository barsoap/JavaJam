class Users::RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :recipe_tags]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.take(10)
    if params[:tag_id]
      @recipes = Tag.find(params[:tag_id]).recipes.page(params[:page]).per(12)
    else
      case params[:sort]
      when 'recipe_latest'
        @recipes = Recipe.page(params[:page]).per(12).order(created_at: :desc)
      when 'recipe_oldest'
        @recipes = Recipe.page(params[:page]).per(12).order(created_at: :asc)
      when 'evaluation'
        @recipes = Recipe.page(params[:page]).per(12).order(evaluation: :desc)
      else
        @recipes = Recipe.page(params[:page]).per(12).order(created_at: :desc)
      end
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    # トランザクション
    ActiveRecord::Base.transaction do
      if @recipe.save
        @recipe.save_tags(params[:recipe][:tags]) if params[:recipe][:tags].present?
        redirect_to recipe_path(@recipe)
      else
        render :new
      end
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    # トランザクション
    ActiveRecord::Base.transaction do
      if @recipe.update(recipe_params)
        @recipe.save_tags(params[:recipe][:tags]) if params[:recipe][:tags].present?
        redirect_to recipe_path(@recipe)
      else
        render :edit
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  def recipe_tags
    @tags = Tag.all
  end


  private
  def recipe_params
    params.require(:recipe).permit(:user_id, :title, :contents, :recipe_image, :evaluation,
                                  recipe_processes_attributes: [:id, :process, :description, :recipe_process_image, :_destroy])
  end

  #アクセス制限
  def is_matching_login_user
    recipe = Recipe.find(params[:id])
    unless recipe.user == current_user
      redirect_to recipe_path
    end
  end

end