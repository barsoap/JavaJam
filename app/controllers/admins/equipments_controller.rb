class Admins::EquipmentsController < ApplicationController
  def index
    @equipments = Equipment.page(params[:page]).per(10)
  end

  def show
    @equipment = Equipment.find(params[:id])
  end

  def destroy
    equipment = Equipment.find(params[:id])
    equipment.destroy
    redirect_to admins_equipments_path
  end
end
