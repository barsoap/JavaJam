class Users::EquipmentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    case params[:sort]
      when 'equipment_latest'
        @equipments = Equipment.page(params[:page]).per(12).order(created_at: :desc)
      when 'equipment_oldest'
        @equipments = Equipment.page(params[:page]).per(12).order(created_at: :asc)
      when 'evaluation'
        @equipments = Equipment.page(params[:page]).per(12).order(evaluation: :desc)
      else
        @equipments = Equipment.page(params[:page]).per(12).order(created_at: :desc)
    end
  end

  def show
    @equipment = Equipment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
      redirect_to equipments_path
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.user_id = current_user.id
    if @equipment.save
      redirect_to equipment_path(@equipment)
    else
      render :new
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])
    unless @equipment.user_id == current_user.id
      redirect_to equipment_path(@equipment)
    end
  end

  def update
    @equipment = Equipment.find(params[:id])
    if @equipment.update(equipment_params)
      redirect_to equipment_path(@equipment)
    else
      render :edit
    end
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy
    redirect_to equipments_path
  end

  private
  def equipment_params
    params.require(:equipment).permit(:user_id, :name, :description, :evaluation, :equipment_image)
  end

  #アクセス制限
  def is_matching_login_user
    equipment = Equipment.find(params[:id])
    unless equipment.user == current_user
      redirect_to equipment_path
    end
  end

end
