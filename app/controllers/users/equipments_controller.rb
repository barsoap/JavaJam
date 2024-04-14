class Users::EquipmentsController < ApplicationController
  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new
    @equipment.user_id = current_user.id
    if @equipment.save
      redirect_to equipment_path(@equipment)
    else
      render :new
    end
  end

  def index
    @equipments = Equipment.all
  end

  def show
    @equipment = Equipment.find(params[:id])
  end

  def edit
    @equipment = Equipment.find(params[:id])
    unless @equipment.user_id == current_user.id
      redirect_to equipment_path(@equipment)
    end
  end

  def update
    @equipment = Equipment.find(params[:id])
    if @equipment.save(equipment_params)
      redirect_to equipment_path(@equipment)
    else
      render :edit
    end
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy
    redirect_to equipment_index_path
  end

  private
  def equipment_params
    params.require(:equipment).permit(:user_id, :name, :description, :evaluation)
  end

end
