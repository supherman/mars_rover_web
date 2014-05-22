class RoversController < ApplicationController
  def new
    @rover = Rover.new grid
    redirect_to rover_path(@rover.id)
  end

  def show
    @rover = Rover.new grid, id: params[:id]
  end
end
