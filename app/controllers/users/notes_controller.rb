class Users::NotesController < ApplicationController
  def index
    case params[:sort]
      when 'note_latest'
        @notes = Note.page(params[:page]).per(12).order(created_at: :desc)
      when 'note_oldest'
        @notes = Note.page(params[:page]).per(12).order(created_at: :asc)
      else
        @notes = Note.page(params[:page]).per(12).order(created_at: :desc)
    end
  end

  def show
    @note = Note.find(params[:id])
  end

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
    params.require(:note).permit(:user_id, :title, :contents, :note_image)
  end
end
