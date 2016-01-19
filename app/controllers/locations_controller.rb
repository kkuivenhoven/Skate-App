class LocationsController < ApplicationController
  before_filter :login_required, only: [:new, :create, :edit, :update, :destroy]
  before_filter :created_by_this_user, only: [:edit, :update, :destroy]

#  def index
#    @locations = Location.all
#  end
#
#  def show
#    @location = Location.find(params[:id])
#  end

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

#  def edit
#    @location = Location.find(params[:id])
#  end
#
#  def update
#    @location = Location.find(params[:id])
#    @skate_spot = SkateSpot.find_by(@location.skate_spot_id)
#    #if @skate_spot.location.update(params.require(:location).permit(:address))
#    #if @location.update(params.require(:location).permit(:address))
#    if @location.update_attribute('address', @location.address)
#      redirect_to @location, notice: "Location has been successfully updated!"
#    else
#      render :edit
#    end
#  end

  def destroy
    Location.find(params[:id]).destroy
    #redirect_to :action => 'index'
    redirect_to skate_spots_url
  end

  private

    def login_required
      redirect_to login_path unless logged_in?
    end

    def created_by_this_user
      if !current_user.nil?
        @skate_spot = current_user.skate_spots.find_by(id: params[:id])
        redirect_to(skate_spots_url) if @skate_spot.nil?
      end
    end

    def location_params
      params.require(:location).permit(:address, :city, :state, :country)
      #params.require(:location).permit(:skate_spot_id)
    end
 
end
