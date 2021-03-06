class SkateSpotsController < ApplicationController

	def recommender
	end

  def index
	 if (!params[:zip_code].nil?) and (!params[:mileage].nil?)
	 # if (params[:zip_code].length >= 0) and (params[:mileage].length >= 0)
		 if (params[:zip_code].length == 5) and (params[:mileage].length > 1)
				# @skate_spots = SkateSpot.near(Geocoder.coordinates("#{params[:zip_code]}"), params[:mileage], :order => 'distance')
				@skate_spots = SkateSpot.near(Geocoder.coordinates("#{params[:zip_code]}"), params[:mileage], :order => false)
				if params[:street] == "1"
					@skate_spots = @skate_spots.where(:street_spot => true)
				elsif params[:park] == "1"
					@skate_spots = @skate_spots.where(:park_spot => true)
				# else
					# @skate_spots = SkateSpot.all
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


		@notNil = @skate_spots.where.not(user_votes: nil)
		if @notNil.any?
			@values = @notNil.pluck(:id, :user_votes)
			@UV_IDs = Array.new 
			@DV_IDs = Array.new
			@BOTH_IDs = Array.new
			@values.each do |value|
				@up_Tot = 0
				@down_Tot = 0
				value[1].each do |k, val|
					if val == "1" 
						@up_Tot += 1
					end 
					if val == "0" 
						@down_Tot += 1
					end
				end # end of iterating through skate_spot up_votes & down_votes
				if @up_Tot > @down_Tot
						 @UV_IDs << value[0]
						 @BOTH_IDs << value[0]
				end 
				if @up_Tot < @down_Tot
				# if @down_Tot > @downCount.to_i
						 @DV_IDs << value[0]
						 @BOTH_IDs << value[0]
				end
			end
		end


    if ((params[:commit] == "Search") or (!params[:search].nil?))
			 if params[:search].length != 0
		  		@skate_spots = @skate_spots.search(params[:search])
		   end
			 if ((params[:upvotes][:upvoteFilter] == "1") and (params[:downvotes][:downvoteFilter] == "1"))
					 @skate_spots = SkateSpot.find_spots(params, @skate_spots, @BOTH_IDs)
			 end
			 if ((params[:upvotes][:upvoteFilter] == "1") and (params[:downvotes][:downvoteFilter] == "0"))
					@skate_spots = SkateSpot.find_spots(params, @skate_spots, @UV_IDs)
			 end
		   if ((params[:upvotes][:upvoteFilter] == "0") and (params[:downvotes][:downvoteFilter] == "1"))
					@skate_spots = SkateSpot.find_spots(params, @skate_spots, @DV_IDs)
			 end
			 if ((params[:upvotes][:upvoteFilter] == "0") and (params[:downvotes][:downvoteFilter] == "0"))
				 if @skate_spots.any?
				  	@skate_spots = SkateSpot.find_spots(params, @skate_spots, [])
				 else
					 @skate_spots = nil
				 end
			 end
			 if !@skate_spots.nil?
				 @all_latlng = Array.new
				 @skate_spots.each do |s|
								 @all_latlng << s.name
								 @all_latlng << s.latitude
								 @all_latlng << s.longitude
				 end
			 end
		else
			@skate_spots = @skate_spots.order(:name)
		end
  end



  def show
		if !current_user.nil?
			@rating_items = current_user.rating_feed.paginate(page: params[:page])
		end
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

		@skate_spots = SkateSpot.where.not(id: @skate_spot.id)
	  @sprSprMatch = @skate_spots.where(street_spot: @skate_spot.street_spot, park_spot: @skate_spot.park_spot, gated: @skate_spot.gated, wood: @skate_spot.wood, metal: @skate_spot.metal, concrete: @skate_spot.concrete, street_plaza: @skate_spot.street_plaza, transition: @skate_spot.transition, skate_spot_size: @skate_spot.skate_spot_size, neighborhood_spot_size: @skate_spot.neighborhood_spot_size, regional_spot_size: @skate_spot.regional_spot_size, wcmx_accessible: @skate_spot.wcmx_accessible, bmx_accessible: @skate_spot.bmx_accessible)

	  @sprMatch = @skate_spots.where(street_spot: @skate_spot.street_spot, park_spot: @skate_spot.park_spot, wood: @skate_spot.wood, metal: @skate_spot.metal, concrete: @skate_spot.concrete, street_plaza: @skate_spot.street_plaza, transition: @skate_spot.transition, wcmx_accessible: @skate_spot.wcmx_accessible, bmx_accessible: @skate_spot.bmx_accessible)

	  @match = @skate_spots.where(street_spot: @skate_spot.street_spot, park_spot: @skate_spot.park_spot, street_plaza: @skate_spot.street_plaza, transition: @skate_spot.transition)

		if @skate_spot.ratings.count != 0

		  @diffAvg = @ratings.average(:difficulty).truncate(2)
			@lowdiff = @diffAvg - 1
		  @lowdiff = ("%.2f" % @lowdiff).to_f
			@highdiff = @diffAvg + 1
		  @highdiff = ("%.2f" % @highdiff).to_f
			@m_lowdiff = @diffAvg - 2
		  @m_lowdiff = ("%.2f" % @lowdiff).to_f
			@m_highdiff = @diffAvg + 2
		  @m_highdiff = ("%.2f" % @highdiff).to_f
			@diffAvg = @diffAvg.to_f

		  @secAvg = @ratings.average(:police).truncate(2)
		  # @securityAvg = "%.2f" % @securityAvg
			@lowSec = @secAvg - 1
		  @lowSec = ("%.2f" % @lowSec).to_f
			@highSec = @secAvg + 1
		  @highSec = ("%.2f" % @highSec).to_f
			@m_lowSec = @secAvg - 2
		  @m_lowSec = ("%.2f" % @lowSec).to_f
			@m_highSec = @secAvg + 2
		  @m_highSec = ("%.2f" % @highSec).to_f
			@secAvg = @secAvg.to_f

		  @pedAvg = @ratings.average(:pedestrian).truncate(2)
		  # @pedAvg = "%.2f" % @pedAvg
			@lowPed = @pedAvg - 1
		  @lowPed = ("%.2f" % @lowPed).to_f
			@highPed = @pedAvg + 1
		  @highPed = ("%.2f" % @highPed).to_f
			@m_lowPed = @pedAvg - 2
		  @m_lowPed = ("%.2f" % @lowPed).to_f
			@m_highPed = @pedAvg + 2
		  @m_highPed = ("%.2f" % @highPed).to_f
			@pedAvg = @pedAvg.to_f

			if @sprSprMatch.count != 0
				@sprSprRatings = Rating.where(id: @sprSprMatch.ids)
				@sprSprRatings = @sprSprRatings.group_by(&:skate_spot_id)
			end

			if @sprMatch.count != 0
				@sprRatings = Rating.where(id: @sprMatch.ids)
				@sprRatings = @sprRatings.group_by(&:skate_spot_id)
			end

			if @match.count != 0
				@m_ratings = Rating.where(id: @match.ids)
				@m_ratings = @m_ratings.group_by(&:skate_spot_id)
			end

			if @sprSprMatch.count != 0
				@id_vals = Array.new
				@sprSprSort = Hash.new
				@sprSprRatings.each do |k,v|
					 @ss = SkateSpot.find(k)
					 @tmp = Hash.new
					 @tmp["avgDiff"] = ("%.2f" % (@ss.ratings.average(:difficulty).truncate(2))).to_f
					 @tmp["avgSec"] = ("%.2f" % (@ss.ratings.average(:police).truncate(2))).to_f
					 @tmp["avgPed"] = ("%.2f" % (@ss.ratings.average(:pedestrian).truncate(2))).to_f
					 @sprSprSort[k] = @tmp  
					 @id_vals << k
				end 
				# @sprSpr_ids = SkateSpot.get_recommendations(@sprSprSort, @diffAvg, @diffAvg, @secAvg, @secAvg, @pedAvg, @pedAvg)
				@sprSpr_ids = @skate_spots.get_recommendations(@sprSprSort, @diffAvg, @diffAvg, @secAvg, @secAvg, @pedAvg, @pedAvg)
				# @sprSpr_ids = SkateSpot.where(id: @id_vals).get_recommendations(@sprSprSort, @diffAvg, @diffAvg, @secAvg, @secAvg, @pedAvg, @pedAvg)
			  @sprSpr_ids.delete_if {|s| s == @skate_spot.id}
				@sprSpr_skateSpots = SkateSpot.find(@sprSpr_ids)
			end 

			if @sprMatch.count != 0
				@sprSort = Hash.new
				@sprRatings.each do |k,v|
					 @ss = SkateSpot.find(k)
					 @tmp = Hash.new
					 @tmp["avgDiff"] = ("%.2f" % (@ss.ratings.average(:difficulty).truncate(2))).to_f
					 @tmp["avgSec"] = ("%.2f" % (@ss.ratings.average(:police).truncate(2))).to_f
					 @tmp["avgPed"] = ("%.2f" % (@ss.ratings.average(:pedestrian).truncate(2))).to_f
					 @sprSort[k] = @tmp  
				end 
				# @spr_ids = SkateSpot.get_recommendations(@sprSort, @lowdiff, @highdiff, @lowSec, @highSec, @lowPed, @highPed)
				@spr_ids = @skate_spots.get_recommendations(@sprSort, @lowdiff, @highdiff, @lowSec, @highSec, @lowPed, @highPed)
			  @spr_ids.delete_if {|s| s == @skate_spot.id}
				@spr_skateSpots = SkateSpot.find(@spr_ids)
			end 

			if @match.count != 0
				@m_sort = Hash.new
				@m_ratings.each do |k,v|
					 @ss1 = SkateSpot.find(k)
					 @tmp = Hash.new
					 @tmp["avgDiff"] = ("%.2f" % (@ss1.ratings.average(:difficulty).truncate(2))).to_f
					 @tmp["avgSec"] = ("%.2f" % (@ss1.ratings.average(:police).truncate(2))).to_f
					 @tmp["avgPed"] = ("%.2f" % (@ss1.ratings.average(:pedestrian).truncate(2))).to_f
					 @m_sort[k] = @tmp  
				end 
				# @m_ids = SkateSpot.get_recommendations(@m_sort, @m_lowdiff, @m_highdiff, @m_lowSec, @m_highSec, @m_lowPed, @m_highPed)
				@m_ids = @skate_spots.get_recommendations(@m_sort, @m_lowdiff, @m_highdiff, @m_lowSec, @m_highSec, @m_lowPed, @m_highPed)
			  @m_ids.delete_if {|s| s == @skate_spot.id}
				@m_skateSpots = SkateSpot.find(@m_ids)
			end 
    end

		if !@events.nil?
			@laFecha = DateTime.now.all_month
			@newEvents = @events.map{ |c| c.date.to_date if @laFecha.cover?(c.date)}.compact
			@keyEvents = @events.map{ |c| c.date if @laFecha.cover?(c.date)}.compact
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
		@skate_spot.number = @addr_comp[0]["long_name"]
		@skate_spot.street = @addr_comp[1]["long_name"]
		@skate_spot.city = @addr_comp[2]["long_name"]
		@skate_spot.state = @addr_comp[4]["short_name"]
		@skate_spot.zip_code = @addr_comp[6]["long_name"]
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
    if @skate_spot.update(skate_spot_params)
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

    def geo_skate_spot_params
      params.require(:skate_spot).permit(:name, :latitude, :longitude, :park_spot, :street_spot, :gated, :concrete, :wood, :metal, :transition, :street_plaza, :skate_spot_size, :neighborhood_spot_size, :regional_spot_size, :wcmx_accessible, :bmx_accessible)
    end

    def skate_spot_params
      params.require(:skate_spot).permit(:name, :number, :street, :city, :state, :country, :zip_code, :park_spot, :street_spot, :gated, :concrete, :wood, :metal, :transition, :street_plaza, :skate_spot_size, :neighborhood_spot_size, :regional_spot_size, :wcmx_accessible, :bmx_accessible)
    end

end
