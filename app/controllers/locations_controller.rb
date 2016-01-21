class LocationsController < ApplicationController
  before_filter :login_required, only: [:new, :create, :edit, :update, :destroy]
  before_filter :created_by_this_user, only: [:edit, :update, :destroy]

  #declares a new location
  def new
    @location = Location.new
  end

  #creates the new location
  def create
    @location = Location.new(params[:location_params])
    if @location.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  #destroys the specified location
  def destroy
    Location.find(params[:id]).destroy
    redirect_to skate_spots_url
  end

  private

    #guarantees a user is logged in before allowing anyone to access any of the public functions
    def login_required
      redirect_to login_path unless logged_in?
    end

    #makes sure that if the location is being deleted by a user, that the user created that location
    def created_by_this_user
      if !current_user.nil?
        @skate_spot = current_user.skate_spots.find_by(id: params[:id])
        redirect_to(skate_spots_url) if @skate_spot.nil?
      end
    end

    #the parameters that are necessary for the creation of a location object
    def location_params
      params.require(:location).permit(:address, :city, :state, :country)
    end
 
end
