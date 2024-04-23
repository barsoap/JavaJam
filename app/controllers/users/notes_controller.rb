class Users::NotesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      redirect_to note_path(@note)
    else
      render :new
    end
  end

  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
    @note = Note.find(params[:id])
    unless @note.user_id == current_user.id
      redirect_to note_path(@note)
    end
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to note_path(@note)
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to notes_path
  end

  private
  def note_params
    params.require(:note).permit(:user_id, :title, :contents)
  end

  #アクセス制限
  def is_matching_login_user
    note = Note.find(params[:id])
    unless note.user == current_user
      redirect_to note_path
    end
  end
end
