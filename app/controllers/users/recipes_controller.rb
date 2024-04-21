class Users::RecipesController < ApplicationController

  def index
    @tags = Tag.take(10)
    if params[:tag_id]
      @recipes = Tag.find(params[:tag_id]).recipes
    else
      case params[:sort]
      when 'recipe_latest'
        @recipes = Recipe.order(created_at: :desc)
      when 'recipe_oldest'
        @recipes = Recipe.order(created_at: :asc)
      when 'evaluation'
        @recipes = Recipe.order(evaluation: :desc)
      else
        @recipes = Recipe.order(created_at: :desc)
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
    if @recipe.save
      @recipe.save_tags(params[:recipe][:tags]) if params[:recipe][:tags].present?
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      @recipe.save_tags(params[:recipe][:tags]) if params[:recipe][:tags].present?
      redirect_to recipe_path(@recipe)
    else
      render :edit
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

end