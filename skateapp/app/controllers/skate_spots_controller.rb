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
    #@skate_spot = SkateSpot.new(skate_spot_params)
    @skate_spot = SkateSpot.new(params[:skate_spot_params])

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
    if @skate_spot.update(params.require(:skatespot).permit(:location_id))
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
      params.require(:skate_spot).permit(:location_id, :name)
    end
end
