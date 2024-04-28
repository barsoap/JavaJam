class Users::SearchsController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    #ユーザー検索
    if @model == 'user'
      @records = User.search_for(@content)
    elsif @model == 'recipe'
      @records = Recipe.search_for(@content)
    elsif @model == 'equipment'
      @records = Equipment.search_for(@content)
    elsif @model == 'note'
      @records = Note.search_for(@content)
    end
  end

end
