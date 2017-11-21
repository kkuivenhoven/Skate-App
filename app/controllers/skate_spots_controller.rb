class SkateSpotsController < ApplicationController

	def recommender
	end

  def index
	 if (!params[:zip_code].nil?) and (!params[:mileage].nil?)
		 if (params[:zip_code].length == 5) and (params[:mileage].length > 1)
				@skate_spots = SkateSpot.near(Geocoder.coordinates("#{params[:zip_code]}"), params[:mileage])
				if params[:street] == "1"
					@skate_spots = @skate_spots.where(:street_spot => true)
				elsif params[:park] == "1"
					@skate_spots = @skate_spots.where(:park_spot => true)
				end
		 else
				if params[:street] == "1"
					@skate_spots = @skate_spots.where(:street_spot => true)
				elsif params[:park] == "1"
					@skate_spots = @skate_spots.where(:park_spot => true)
				else
					@skate_spots = SkateSpot.all
				end
		 end
	 else
			if params[:street] == "1"
				@skate_spots = SkateSpot.where(:street_spot => true)
			elsif params[:park] == "1"
				@skate_spots = SkateSpot.where(:park_spot => true)
			else
				@skate_spots = SkateSpot.all
			end
			# @skate_spots = SkateSpot.all
	 end
		@hash = @skate_spots.map {|a| {lat: a.latitude, long: a.longitude} }
    @skate_spots = @skate_spots.order(:name)
		@all_latlng = Array.new
		@skate_spots.each do |s|
						@all_latlng << s.name
						@all_latlng << s.latitude
						@all_latlng << s.longitude
		end

		@upCount = 0
		@downCount = 0
		@UV_vals = @skate_spots.pluck(:user_votes)
		@UV_vals.delete_if &:empty?
    @UV_vals.each do |uv| 
      uv.each do |k,v|
			 if v == "1" 
				@upCount += 1
			 elsif v == "0" 
				@downCount += 1
			 end 
      end
    end

		@notNil = @skate_spots.where.not(user_votes: nil)
		@values = @notNil.pluck(:id, :user_votes)
		@up_IDs = Array.new 
		@down_IDs = Array.new
		@values.each do |v|
			@up_Tot = 0
			@down_Tot = 0
			v[1].each do |k, val|
				if val == "1" 
					@up_Tot += 1
				end 
				if val == "0" 
					@down_Tot += 1
				end
			end
			if @up_Tot > @upCount.to_i
					 @up_IDs << v[0]
			end 
			if @down_Tot > @downCount.to_i
					 @down_IDs << v[0]
			end
		end


		@upCount = "%.2f" % @upCount
		@downCount = "%.2f" % @downCount
		@upCount = @upCount.to_f/SkateSpot.count
		@downCount = @downCount.to_f/SkateSpot.count

		if params[:search]
			 if params[:upvotes][:upvoteFilter] == "1"
					@skate_spots = @skate_spots.find(@up_IDs)
				  if params[:metal][:metal] == "1"
						@skate_spots = @skate_spots.where("metal = ?", true)
					end
				  if params[:wood][:wood] == "1"
						@skate_spots = @skate_spots.where("wood = ?", true)
				  end
				  if params[:concrete][:concrete] == "1"
						@skate_spots = @skate_spots.where("concrete = ?", true)
					end
					if params[:gated][:gated] == "1"
						@skate_spots = @skate_spots.where("gated = ?", true)
					end
					if params[:spotSize][:spotSize] == "1"
						@skate_spots = @skate_spots.where("skate_spot_size = ?", true)
					elsif params[:neighSize][:neighspotSize] == "1"
						@skate_spots = @skate_spots.where("neighborhood_spot_size = ?", true)
					elsif params[:regSize][:regSize] == "1"
						@skate_spots = @skate_spots.where("regional_spot_size = ?", true)
					end
					if params[:transition][:transition] == "1"
						@skate_spots = @skate_spots.where("transition = ?", true)
					end
					if params[:streetPlaza][:streetPlaza] == "1"
						@skate_spots = @skate_spots.where("street_plaza = ?", true)
				  end
					@skate_spots = @skate_spots.search(params[:search])
			 elsif params[:downvotes][:downvoteFilter] == "1"
					@skate_spots = @skate_spots.find(@down_IDs)
				  if params[:metal][:metal] == "1"
						@skate_spots = @skate_spots.where("metal = ?", true)
					end
				  if params[:wood][:wood] == "1"
						@skate_spots = @skate_spots.where("wood = ?", true)
					end
				  if params[:concrete][:concrete] == "1"
						@skate_spots = @skate_spots.where("concrete = ?", true)
					end
					if params[:gated][:gated] == "1"
						@skate_spots = @skate_spots.where("gated = ?", true)
					end
					if params[:spotSize][:spotSize] == "1"
						@skate_spots = @skate_spots.where("skate_spot_size = ?", true)
					elsif params[:neighSize][:neighspotSize] == "1"
						@skate_spots = @skate_spots.where("neighborhood_spot_size = ?", true)
					elsif params[:regSize][:regSize] == "1"
						@skate_spots = @skate_spots.where("regional_spot_size = ?", true)
					end
					if params[:transition][:transition] == "1"
						@skate_spots = @skate_spots.where("transition = ?", true)
					end
					if params[:streetPlaza][:streetPlaza] == "1"
						@skate_spots = @skate_spots.where("street_plaza = ?", true)
				  end
					@skate_spots = @skate_spots.search(params[:search])
			 else
				  if params[:metal][:metal] == "1"
						@skate_spots = @skate_spots.where("metal = ?", true)
				  end
				  if params[:wood][:wood] == "1"
						@skate_spots = @skate_spots.where("wood = ?", true)
				  end
				  if params[:concrete][:concrete] == "1"
						@skate_spots = @skate_spots.where("concrete = ?", true)
					end
					if params[:gated][:gated] == "1"
						@skate_spots = @skate_spots.where("gated = ?", true)
					end
					if params[:spotSize][:spotSize] == "1"
						@skate_spots = @skate_spots.where("skate_spot_size = ?", true)
					elsif params[:neighSize][:neighspotSize] == "1"
						@skate_spots = @skate_spots.where("neighborhood_spot_size = ?", true)
					elsif params[:regSize][:regSize] == "1"
						@skate_spots = @skate_spots.where("regional_spot_size = ?", true)
					end
					if params[:transition][:transition] == "1"
						@skate_spots = @skate_spots.where("transition = ?", true)
					end
					if params[:streetPlaza][:streetPlaza] == "1"
						@skate_spots = @skate_spots.where("street_plaza = ?", true)
				  end
					# @skate_spots = @skate_spots.search(params[:search])
					# if params[:zip_code].length == 5
					# 	 if params[:mileage].length > 1
					# 			@skate_spots = @skate_spots.near(Geocoder.coordinates("#{params[:mileage]}"))
					# 	 end
					# end
					@skate_spots = @skate_spots.search(params[:search])
			 end
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
    @rating_items = current_user.rating_feed.paginate(page: params[:page])
    @skate_spot = SkateSpot.find(params[:id])
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
		@events = @skate_spot.events

		@rate_skate = Array.new
		@ratings = @skate_spot.ratings

		@skate_spots = SkateSpot.all
		if @skate_spot.ratings.count != 0

		  @diffAvg = @ratings.average(:difficulty).truncate(2)
		  # @diffAvg = "%.2f" % @diffAvg
			@lowdiff = @diffAvg - 1
		  @lowdiff = "%.2f" % @lowdiff
			@highdiff = @diffAvg + 1
		  @highdiff = "%.2f" % @highdiff

		  @secAvg = @ratings.average(:police).truncate(2)
		  # @securityAvg = "%.2f" % @securityAvg
			@lowSec = @secAvg - 1
		  @lowSec = "%.2f" % @lowSec
			@highSec = @secAvg + 1
		  @highSec = "%.2f" % @highSec

		  @pedAvg = @ratings.average(:pedestrian).truncate(2)
		  # @pedAvg = "%.2f" % @pedAvg
			@lowPed = @pedAvg - 1
		  @lowPed = "%.2f" % @lowPed
			@highPed = @pedAvg + 1
		  @highPed = "%.2f" % @highPed

			@skate_spots.each do |s|
					if s.ratings.count != 0
						if s.id != @skate_spot.id
								@stuff = s.ratings.where(:difficulty => @lowdiff..@highdiff, :police => @lowSec..@highSec)
								# @filter_diff = s.ratings.where(:difficulty => @lowdiff..@highdiff)
								# if @filter_diff.count != 0
							# 			@filter_sec = @filter_diff.where(:police => @lowSec..@highSec)
							# 			if @filter_sec.count != 0
							# 			    @filter_ped = @filter_sec.where(:pedestrian => @lowPed..@highPed)
							# 			    if @filter_ped.count != 0
							# 								@rate_skate << s.ratings
					     #          end
					      #     end
					      # end
					  end
					end
			end
		end
		@ss_ids = Array.new
		if @rate_skate.count > 0
				# @rate_skate.delete_if { |difficulty| difficulty != @diffAvg }
				@rate_skate.each do |r_s|
						@ss_ids << r_s[0].skate_spot_id
				    # r_s.delete_if { |difficulty| difficulty != @diffAvg }
        end
    end
		if @ss_ids.count > 0 
			@final_spots = SkateSpot.where(id: @ss_ids)
		end
=begin
		# if @final_spots.count > 0 
		if !@final_spots.nil?
			 @final_spots.each do |f_s|
					# removes SS if category of f_s doesn't match @skate_spot category
				  if f_s.street_spot != @skate_spot.street_spot	
							@final_spots.delete(f_s)
			    end
				  if f_s.park_spot != @skate_spot.park_spot	
							@final_spots.delete(f_s)
			    end

					# removes SS if gated of f_s doesn't match @skate_spot gated
				  if f_s.gated != @skate_spot.gated	
						  # @g_to_delete = f_s
							# @final_spots.reject!{|ss| ss == @g_to_delete}
							# @index = @final_spots.index(f_s)
							@final_spots.delete(f_s)
			    end

					# removes SS if material of f_s doesn't match @skate_spot material
				  if f_s.wood != @skate_spot.wood	
							@final_spots.delete(f_s)
			    end
				  if f_s.metal != @skate_spot.metal	
							@final_spots.delete(f_s)
			    end
				  if f_s.concrete != @skate_spot.concrete	
							@final_spots.delete(f_s)
			    end

					# removes SS if type of f_s doesn't match @skate_spot type
				  if f_s.transition != @skate_spot.transition	
							@final_spots.delete(f_s)
			    end
				  if f_s.street_plaza != @skate_spot.street_plaza	
							@final_spots.delete(f_s)
			    end

					# removes SS if spot size of f_s doesn't match @skate_spot spot size
				  if f_s.neighborhood_spot_size != @skate_spot.neighborhood_spot_size	
							@final_spots.delete(f_s)
			    end
				  if f_s.regional_spot_size != @skate_spot.regional_spot_size	
							@final_spots.delete(f_s)
			    end
				  if f_s.skate_spot_size != @skate_spot.skate_spot_size	
							@final_spots.delete(f_s)
			    end

			 end
    end
=end
  end

  def new_by_geo
    @skate_spot = SkateSpot.new
  end

  def create_by_geo
    @skate_spot = SkateSpot.new(geo_skate_spot_params)
		geo_localization = "#{@skate_spot.latitude},#{@skate_spot.longitude}"
		@query = Geocoder.search(geo_localization).first
		@addr_comp = @query.data["address_components"]
		# @skate_spot.number = @addr_comp.first["long_name"]
		@skate_spot.number = @addr_comp[0]["long_name"]
		# @skate_spot.street = @addr_comp.second["long_name"]
		@skate_spot.street = @addr_comp[1]["long_name"]
		# @skate_spot.city = @addr_comp.fourth["long_name"]
		@skate_spot.city = @addr_comp[2]["long_name"]
		# @skate_spot.state = @addr_comp[5]["short_name"]
		@skate_spot.state = @addr_comp[4]["short_name"]
		# @skate_spot.zip_code = @addr_comp[7]["long_name"]
		@skate_spot.zip_code = @addr_comp[6]["long_name"]
		# @skate_spot.country = @addr_comp[6]["short_name"]
		@skate_spot.country = @addr_comp[5]["short_name"]
		@skate_spot.user_id = current_user.id
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
		@skate_spot.user_id = current_user.id
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

	def like_ss
    @skate_spot = SkateSpot.find(params[:skate_spot])
		@skate_spot.update_attribute(:user_votes, @skate_spot.user_votes.merge!(current_user.id => params[:vote_value]))
    redirect_to @skate_spot
	end

	def dislike_ss
    @skate_spot = SkateSpot.find(params[:skate_spot])
		@skate_spot.update_attribute(:user_votes, @skate_spot.user_votes.merge!(current_user.id => params[:vote_value]))
    redirect_to @skate_spot
	end

  private
    #Use callbacks to share common setup or constraints between actions
#    def set_skate_spot
#      @skate_spot = SkateSpot.find(params[:id])
#    end

    def geo_skate_spot_params
      # params.require(:skate_spot).permit(:name, :latitude, :longitude, :park_spot, :street_spot)
      params.require(:skate_spot).permit(:name, :latitude, :longitude, :park_spot, :street_spot, :gated, :wood, :metal, :transition, :street_plaza, :skate_spot_size, :neighborhood_spot_size, :regional_spot_size)
    end

    def skate_spot_params
      params.require(:skate_spot).permit(:name, :number, :street, :city, :state, :country, :zip_code, :park_spot, :street_spot, :gated, :wood, :metal, :transition, :street_plaza, :skate_spot_size, :neighborhood_spot_size, :regional_spot_size)
    end

end
