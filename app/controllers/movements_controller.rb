class MovementsController < ApplicationController
  respond_to :json

  def create
    rover = Rover.new grid, id: params[:rover_id]
    rover.send(params[:movement])
    respond_with rover, location: rover_url(rover.id)
  end
end
