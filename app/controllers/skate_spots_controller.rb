class SkateSpotsController < ApplicationController

  def index
    @skate_spots = SkateSpot.all
  end

  def show
    @skate_spot = SkateSpot.find(params[:id])
		@address = @skate_spot.get_coords
		lat = @skate_spot.get_lat
		long = @skate_spot.get_long
    @hash = Gmaps4rails.build_markers(@skate_spot) do |skate_spot, marker|
      marker.lat lat
      marker.lat long
      #marker.lng address[1]
      #marker.title skate_spot.name
    end
  end

  def new
    @skate_spot = SkateSpot.new
  end

  def create
    @skate_spot = SkateSpot.new(skate_spot_params)

    if @skate_spot.save
	      #@skate_spot.latitude = @skate_spot.get_lat
	      #@skate_spot.longitude = @skate_spot.get_long
			  #@skate_spot.save 
        redirect_to :action => 'index'
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
      params.require(:skate_spot).permit(:name, :number, :street, :city, :state, :country, :zip_code)
    end

end
