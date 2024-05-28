class Users::SearchsController < ApplicationController

  def search
    # @model = params[:model]
    @content = params[:content]

    #ユーザー検索
    @users = User.search_for(@content)
    #レシピ検索
    case params[:recipe_sort]
    when 'recipe_latest'
      @recipes = Recipe.search_for(@content).order(created_at: :desc)
    when 'recipe_oldest'
      @recipes = Recipe.search_for(@content).order(created_at: :asc)
    when 'evaluation'
      @recipes = Recipe.search_for(@content).order(evaluation: :desc)
    when 'recipe_bookmark'
      @recipes = Recipe.search_for(@content).sort {|a,b| b.recipe_bookmarks.size <=> a.recipe_bookmarks.size}
    else
      @recipes = Recipe.search_for(@content).order(created_at: :desc)
    end
    #アイテム検索
    case params[:equipment_sort]
    when 'equipment_latest'
      @equipments = Equipment.search_for(@content).order(created_at: :desc)
    when 'equipment_oldest'
      @equipments = Equipment.search_for(@content).order(created_at: :asc)
    when 'evaluation'
      @equipments = Equipment.search_for(@content).order(evaluation: :desc)
    else
      @equipments = Equipment.search_for(@content).order(created_at: :desc)
    end
    #ノート検索
    @notes = Note.search_for(@content)

  end

end
