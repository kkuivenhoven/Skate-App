class SkateSpotsController < ApplicationController

  def index
    @skate_spots = SkateSpot.all
  end

  def show
    @skate_spot = SkateSpot.find(params[:id])
  end

  def new
    @skate_spot = SkateSpot.new
  end

  def create
    @skate_spot = SkateSpot.new(skate_spot_params)

    if @skate_spot.save
      sk8_lat = @skate_spot.zip_code.to_lat
      sk8_lon = @skate_spot.zip_code.to_lon
      #@location = Location.new(params[:sk8_lat, :sk8_long, @skate_spot.id])
      @location = Location.new
      @location.latitude = sk8_lat
      @location.longitude = sk8_lon
      @location.skate_spot_id = @skate_spot.id
      if @location.save
        @skate_spot.location_id = @location.id
        redirect_to :action => 'index'
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @skate_spot = SkateSpot.find(params[:id])
  end

  def update
    @skate_spot = SkateSpot.find(params[:id])
    if @skate_spot.update(params.require(:skatespot).permit(:name, :zip_code))
      redirect_to @skate_spot, notice: "Skatespot has been successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    Skatespot.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  private
    #Use callbacks to share common setup or constraints between actions
#    def set_skate_spot
#      @skate_spot = SkateSpot.find(params[:id])
#    end

    def skate_spot_params
      params.require(:skate_spot).permit(:name, :zip_code)
    end
end
