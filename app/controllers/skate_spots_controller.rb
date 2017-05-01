class SkateSpotsController < ApplicationController

  def index
    @skate_spots = SkateSpot.all
		@hash = @skate_spots.map {|a| {lat: a.latitude, long: a.longitude} }
      @skate_spots = @skate_spots.order(:name)
		@all_latlng = Array.new
		@skate_spots.each do |s|
						@all_latlng << s.name
						@all_latlng << s.latitude
						@all_latlng << s.longitude
		end
		if params[:search]
			 @skate_spots = @skate_spots.search(params[:search])
			 @all_latlng = Array.new
			 @skate_spots.each do |s|
							 @all_latlng << s.name
							 @all_latlng << s.latitude
							 @all_latlng << s.longitude
			 end
		else
			@skate_spots = @skate_spots.order(:name)
		end
  end

  def show
    @skate_spot = SkateSpot.find(params[:id])
		#@address = @skate_spot.get_coords
		@latlng = Array.new
		@latlng << @skate_spot.latitude
		@latlng << @skate_spot.longitude
		geo_localization = "#{@skate_spot.latitude},#{@skate_spot.longitude}"
		@query = Geocoder.search(geo_localization).first
		if @skate_spot.geocoded?
						#@others = SkateSpot.near(@latlng, 100)
						@others = @skate_spot.nearbys(60)
						@others = @others.order(:name)
		end
		@show_latlng = Array.new
		@show_latlng << @skate_spot.name
		@show_latlng << @skate_spot.latitude
		@show_latlng << @skate_spot.longitude
		@others.each do |s|
			 @show_latlng << s.name
			 @show_latlng << s.latitude
			 @show_latlng << s.longitude
		end
  end

  def new_by_geo
    @skate_spot = SkateSpot.new
  end

  def create_by_geo
    @skate_spot = SkateSpot.new(geo_skate_spot_params)
		geo_localization = "#{@skate_spot.latitude},#{@skate_spot.longitude}"
		@query = Geocoder.search(geo_localization).first
		@addr_comp = @query.data["address_components"]
		@skate_spot.number = @addr_comp.first["long_name"]
		@skate_spot.street = @addr_comp.second["long_name"]
		@skate_spot.city = @addr_comp.fourth["long_name"]
		@skate_spot.state = @addr_comp[5]["short_name"]
		@skate_spot.zip_code = @addr_comp[7]["long_name"]
		@skate_spot.country = @addr_comp[6]["short_name"]
    if @skate_spot.save
        redirect_to :action => 'index'
    else
      render :action => 'new_by_geo'
    end
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

	def test_page
		@skate_spots = SkateSpot.all

	end

  private
    #Use callbacks to share common setup or constraints between actions
#    def set_skate_spot
#      @skate_spot = SkateSpot.find(params[:id])
#    end

    def geo_skate_spot_params
      params.require(:skate_spot).permit(:name, :latitude, :longitude)
    end

    def skate_spot_params
      params.require(:skate_spot).permit(:name, :number, :street, :city, :state, :country, :zip_code)
    end

end
