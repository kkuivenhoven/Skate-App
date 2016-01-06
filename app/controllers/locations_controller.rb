class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location_params])

    if @location.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @skate_spot = SkateSpot.find_by(@location.skate_spot_id)
    #if @skate_spot.location.update(params.require(:location).permit(:address))
    #if @location.update(params.require(:location).permit(:address))
    if @location.update_attribute('address', @location.address)
      redirect_to @location, notice: "Location has been successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    Location.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_location
    #end

    def location_params
      params.require(:location).permit(:skate_spot_id)
    end
 
end
