class Admins::NotesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @notes = Note.page(params[:page]).per(10)
  end

  def show
    @note = Note.find(params[:id])
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    redirect_to admins_notes_path
  end
end
