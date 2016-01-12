#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014
#http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/

class SkateSpotsController < ApplicationController
  before_filter :login_required, only: [:new, :create, :edit, :update, :destroy]
  before_filter :created_by_this_user, only: [:edit, :update, :destroy]

  def index
    @skate_spots = SkateSpot.all
    if params[:search]
      @skate_spots = SkateSpot.search(params[:search]).order("created_at DESC")
    else
      @skate_spots = SkateSpot.order("created_at DESC")
    end
  end

  def search_results
    @skate_spots = SkateSpot.all
    if params[:search]
      @skate_spots = SkateSpot.search(params[:search]).order("created_at DESC")
    else
      @skate_spots = SkateSpot.order("created_at DESC")
    end
  end

  def show
    @skate_spot = SkateSpot.find(params[:id])
    @hash = Gmaps4rails.build_markers(@skate_spots) do |skate_spot, marker|
      marker.lat skate_spot.location.latitude
      marker.lng skate_spot.location.longitude
      marker.title skate_spot.name
    end
  end

  def new
    @skate_spot = SkateSpot.new
  end

  def create
    @skate_spot = current_user.skate_spots.build(skate_spot_params)    
    #@skate_spot = SkateSpot.new(skate_spot_params)

    if @skate_spot.save
      @skate_spot.location = Location.new
      @skate_spot.location.street = @skate_spot.street
      @skate_spot.location.city = @skate_spot.city
      @skate_spot.location.state = @skate_spot.state
      @skate_spot.location.country = @skate_spot.country

      total = Array.new(4)
      total[0] = @skate_spot.street
      total[1] = ' '+@skate_spot.city
      total[2] = @skate_spot.state
      total[3] = @skate_spot.country
      jnd_total = total.join(',')
      @skate_spot.address = jnd_total
      @skate_spot.location.address = jnd_total

      if @skate_spot.location.save
        @location = @skate_spot.location
        @location.skate_spot = @skate_spot
        flash[:success] = "Creation successful!"
        redirect_to skate_spot_path(@skate_spot)
        #redirect_to :action => 'index'
      else
        flash[:danger] = "Creation unsuccessful. Please try again."
        render :action => 'new'
      end
    else
      flash[:danger] = "Creation unsuccessful. Please try again."
      render :action => 'new'
    end
  end

  def edit
    @skate_spot = SkateSpot.find(params[:id])
  end

  def update
    @skate_spot = SkateSpot.find(params[:id])
    @location = @skate_spot.location
    if @skate_spot.update(params.require(:skate_spot).permit(:name, :zip_code))
      @skate_spot.location.street = @skate_spot.street
      @skate_spot.location.city = @skate_spot.city
      @skate_spot.location.state = @skate_spot.state
      @skate_spot.location.country = @skate_spot.country

      total = Array.new(4)
      total[0] = @skate_spot.street
      total[1] = ' '+@skate_spot.city
      total[2] = @skate_spot.state
      total[3] = @skate_spot.country
      jnd_total = total.join(',')
      @skate_spot.address = jnd_total
      @skate_spot.location.address = jnd_total

      if @skate_spot.location.save
        @location = @skate_spot.location
        flash[:success] = "Update successful!"
        redirect_to skate_spot_path(@skate_spot)
      else
        flash[:danger] = "Update unsuccessful. Please try again."
        render :edit
      end
    else
      flash[:danger] = "Update unsuccessful. Please try again."
      render :edit
    end
  end

  def destroy
    if SkateSpot.find(params[:id]).destroy
      flash[:success] = "Deletion successful!"
      redirect_to :action => 'index'
    else
      flash[:danger] = "Deletion unsuccessful. Please try again."
      redirect_to skate_spot_path(@skate_spot)
    end
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

    def skate_spot_params
      params.require(:skate_spot).permit(:name, :street, :city, :state, :country)
      #params.require(:skate_spot).permit(:name, :zip_code)
    end
    
    def rating_params
      params.require(:rating).permit(:difficulty, :police, :pedestrian, :time, :description)
    end
end
