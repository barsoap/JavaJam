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
    else
      @recipes = Recipe.search_for(@content).order(created_at: :desc)
    end

    @equipments = Equipment.search_for(@content)
    @notes = Note.search_for(@content)

  end

end
