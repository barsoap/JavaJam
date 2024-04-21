class Admins::EquipmentsController < ApplicationController
  def index
    @equipments = Equipment.all
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
