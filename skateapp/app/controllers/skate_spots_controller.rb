class SkateSpotsController < ApplicationController

  def index
    @skate_spots = SkateSpot.all
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
    @skate_spot = SkateSpot.new(skate_spot_params)
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
        redirect_to :action => 'index'
      end
    else
      render :action => 'new'
    end
  end

  def new_spot_rating
    #@skate_spot = SkateSpot.find(params[:id])
    @rating = Rating.build(rating_params)
    @skate_spot.ratings = @rating
    #@skate_spot.ratings = Rating.build(rating_params)
    if @skate_spot.ratings.save
      redirect_to @skate_spot
    else
      render :action => 'new_spot_rating'
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
        redirect_to edit_location_path(@location.id)
        #redirect_to @skate_spot, notice: "Skatespot has been successfully updated!"
      end
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
      params.require(:skate_spot).permit(:name, :street, :city, :state, :country)
      #params.require(:skate_spot).permit(:name, :zip_code)
    end
    
    def rating_params
      params.require(:rating).permit(:difficulty, :police, :pedestrian, :time, :description)
    end
end
