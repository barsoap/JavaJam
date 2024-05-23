class Users::SearchsController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    # @method = params[:method]

    #ユーザー検索
    # if @model == 'user'
    #   @records = User.search_for(@content)
    # elsif @model == 'recipe'
    #   @records = Recipe.search_for(@content)
    # elsif @model == 'equipment'
    #   @records = Equipment.search_for(@content)
    # elsif @model == 'note'
    #   @records = Note.search_for(@content)
    # end


    @users = User.search_for(@content)


    case params[:recipe_sort]
    when 'recipe_latest'
      @recipes = Recipe.search_for(@content).order(created_at: :desc)
    when 'recipe_oldest'
      @recipes = Recipe.search_for(@content).order(created_at: :asc)
    when 'evaluation'
      @recipes = Recipe.search_for(@content).order(evaluation: :desc)
    when 'redipe_bookmark'
      @recipes = Recipe.search_for(@content).sort {|a,b| b.recipe_bookmarks.size <=> a.recipe_bookmarks.size}
    else
      @recipes = Recipe.search_for(@content).order(created_at: :desc)
    end

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

    @notes = Note.search_for(@content)

  end

end
