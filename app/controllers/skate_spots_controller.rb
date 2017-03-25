class SkateSpotsController < ApplicationController

  def index
    @skate_spots = SkateSpot.all
		@hash = @skate_spots.map {|a| {lat: a.latitude, long: a.longitude} }
  end

  def show
    @skate_spot = SkateSpot.find(params[:id])
		@address = @skate_spot.get_coords
		@latlng = Array.new
		@latlng << @skate_spot.latitude
		@latlng << @skate_spot.longitude
  end

  def new
    @skate_spot = SkateSpot.new
  end

  def create
    @skate_spot = SkateSpot.new(skate_spot_params)

    if @skate_spot.save
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
    #if @skate_spot.update(params.require(:skatespot).permit(:name, :zip_code))
    if @skate_spot.update(skate_spot_params)
      #redirect_to @skate_spot, notice: "Skatespot has been successfully updated!"
			flash[:success] = "Skatespot has been successfully updated!"
      redirect_to @skate_spot
    else
      render :edit
    end
  end

  def destroy
    SkateSpot.find(params[:id]).destroy
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
