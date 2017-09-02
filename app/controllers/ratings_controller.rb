#Sources:
#http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/
#https://www.railstutorial.org/book, Hartl Michael, 2014
#https://github.com/chrisvfritz/language_filter

class RatingsController < ApplicationController
  before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
  #first, obtain the skate_spot using set_skate_spot
  before_action :set_skate_spot, except: [:index, :testing_this, :index_park_spot, :index_street_spot]
  before_action :users_rating, only: [:edit, :update, :destroy]
  after_action :filter, only: [:create] 

  #GET /skate_spots/:skate_spot_id/ratings/new
  def new
		#@user = User.find_by(id: params[:user_id])
		@user = current_user.id
    #build a new rating
    @rating = @skate_spot.ratings.build
  end

  #POST /skate_spots/:skate_spot_id/ratings
  def create
    #create the rating
    @rating = @skate_spot.ratings.create(rating_params)
    @rating.user_id = current_user.id
    if @rating.save
      flash[:success] = "Rating has been successfully created!"
      redirect_to skate_spot_path(@skate_spot)
    else
      flash[:danger] = "Rating has been unsuccessfully created. Please try again."
      render 'new'
    end
  end

  #GET /skate_spots/:skate_spot_id/ratings/:id/edit
  def edit
    #fetch the rating 
    @rating = @skate_spot.ratings.find(params[:id])
  end

  #update the rating
  #PUT /skate_spots/:skate_spot_id/ratings/:id
  def update
    @rating = @skate_spot.ratings.find(params[:id])
    if @rating.update(rating_params)
      flash[:success] = "Rating has been successfully updated!"
      redirect_to skate_spot_path(@skate_spot)
      #redirect_to([@rating.skate_spot, @rating], :notice => 'Rating has been successfully updated!') 
    else
      flash[:danger] = "Rating has been unsuccesfully updated. Please try again."
      redirect_to skate_spot_path(@skate_spot)
    end
  end

  #destroy the specified rating
  #DELETE /skate_spots/:skate_spot_id/ratings/1
  def destroy
    @rating = @skate_spot.ratings.find(params[:id])
    if @rating.destroy
      flash[:success] = "Rating has been successfully deleted!"
      redirect_to skate_spot_path(@skate_spot)
    else
      flash[:danger] = "Deletion unsuccessful. Please try again."
      redirect_to skate_spot_path(@skate_spot)
    end
  end

	def index_park_spot
		 @skate_spots = SkateSpot.where(:park_spot => true)
		 @ratings = Rating.joins(:skate_spot).where(skate_spots: {park_spot: true})
		 if params[:commit] == "Search"
		 # if params[:search]
			  if params[:first] == "Difficulty(HighLow)"
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, police: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, police: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, police: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, police: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :desc, pedestrian: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :asc, pedestrian: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :asc, pedestrian: :asc)
								else
								end
						end
				end
			  if params[:first] == "Difficulty(LowHigh)"
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, police: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, police: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, police: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, police: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :desc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :asc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :asc, police: :asc)
								else
								end
						end
				end
			  if params[:first] == "Security(HighLow)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :desc, difficulty: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :desc, difficulty: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :desc, difficulty: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :desc, difficulty: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :desc, pedestrian: :desc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :desc, pedestrian: :desc, difficulty: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :desc, pedestrian: :asc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :desc, pedestrian: :asc, difficulty: :asc)
								else
								end
						end
				end
			  if params[:first] == "Security(LowHigh)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :asc, difficulty: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :asc, difficulty: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :asc, difficulty: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :asc, difficulty: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :asc, pedestrian: :desc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :asc, pedestrian: :desc, difficulty: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :asc, pedestrian: :asc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :asc, pedestrian: :asc, difficulty: :asc)
								else
								end
						end
				end
			  if params[:first] == "Pedestrian(HighLow)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :desc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :asc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :asc, police: :asc)
								else
								end
						end
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, police: :desc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, police: :desc, difficulty: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, police: :asc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, police: :asc, difficulty: :asc)
								else
								end
						end
				end
			  if params[:first] == "Pedestrian(LowHigh)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :desc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :asc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :asc, police: :asc)
								else
								end
						end
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, police: :desc, police: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, police: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, police: :asc, police: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, police: :asc, police: :asc)
								else
								end
						end
		    end
		 end
	end

	def index_street_spot
		 @skate_spots = SkateSpot.where(:street_spot => true)
		 @ratings = Rating.joins(:skate_spot).where(skate_spots: {street_spot: true})
		 if params[:commit] == "Search"
		 # if params[:search]
			  if params[:first] == "Difficulty(HighLow)"
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, police: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, police: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, police: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, police: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :desc, pedestrian: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :asc, pedestrian: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :asc, pedestrian: :asc)
								else
								end
						end
				end
			  if params[:first] == "Difficulty(LowHigh)"
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, police: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, police: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, police: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, police: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :desc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :asc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :asc, police: :asc)
								else
								end
						end
				end
			  if params[:first] == "Security(HighLow)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :desc, difficulty: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :desc, difficulty: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :desc, difficulty: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :desc, difficulty: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :desc, pedestrian: :desc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :desc, pedestrian: :desc, difficulty: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :desc, pedestrian: :asc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :desc, pedestrian: :asc, difficulty: :asc)
								else
								end
						end
				end
			  if params[:first] == "Security(LowHigh)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :asc, difficulty: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :asc, difficulty: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :asc, difficulty: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :asc, difficulty: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :asc, pedestrian: :desc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :asc, pedestrian: :desc, difficulty: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :asc, pedestrian: :asc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :asc, pedestrian: :asc, difficulty: :asc)
								else
								end
						end
				end
			  if params[:first] == "Pedestrian(HighLow)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :desc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :asc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :asc, police: :asc)
								else
								end
						end
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, police: :desc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, police: :desc, difficulty: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, police: :asc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, police: :asc, difficulty: :asc)
								else
								end
						end
				end
			  if params[:first] == "Pedestrian(LowHigh)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :desc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :asc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :asc, police: :asc)
								else
								end
						end
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, police: :desc, police: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, police: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, police: :asc, police: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, police: :asc, police: :asc)
								else
								end
						end
		    end
		 end
	end

	def index
		 @skate_spots = SkateSpot.all
		 @ratings = Rating.all
		 @grouped_ratings = @ratings.group_by(&:skate_spot_id)
		 @grouped_ratings.each do |key, g_r|
						 @tmp = g_r.map(&:attributes)
						 @grouped_ratings[key] = nil
						 @grouped_ratings[key] = @tmp
		 end
		 @grouped_ratings.each do |key, g_r|
						 # byebug
		 end
		 @testing = @ratings.group('skate_spot_id')
		 @rating = Rating.first
		 if params[:commit] == "Search"
		 # if params[:search]
			  if params[:first] == "Difficulty(HighLow)"
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, police: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, police: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, police: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, police: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :desc, pedestrian: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :asc, pedestrian: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :desc, pedestrian: :asc, pedestrian: :asc)
								else
								end
						end
				end
			  if params[:first] == "Difficulty(LowHigh)"
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, police: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, police: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, police: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, police: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :desc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :asc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(difficulty: :asc, pedestrian: :asc, police: :asc)
								else
								end
						end
				end
			  if params[:first] == "Security(HighLow)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :desc, difficulty: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :desc, difficulty: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :desc, difficulty: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :desc, difficulty: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :desc, pedestrian: :desc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :desc, pedestrian: :desc, difficulty: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :desc, pedestrian: :asc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :desc, pedestrian: :asc, difficulty: :asc)
								else
								end
						end
				end
			  if params[:first] == "Security(LowHigh)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :asc, difficulty: :desc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :asc, difficulty: :desc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Pedestrian(HighLow)"
										@ratings = @ratings.order(police: :asc, difficulty: :asc, pedestrian: :desc)
				        elsif params[:third] == "Pedestrian(LowHigh)"
										@ratings = @ratings.order(police: :asc, difficulty: :asc, pedestrian: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :asc, pedestrian: :desc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :asc, pedestrian: :desc, difficulty: :asc)
								else
								end
						end
				    if params[:second] == "Pedestrian(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(police: :asc, pedestrian: :asc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(police: :asc, pedestrian: :asc, difficulty: :asc)
								else
								end
						end
				end
			  if params[:first] == "Pedestrian(HighLow)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :desc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :asc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, difficulty: :asc, police: :asc)
								else
								end
						end
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, police: :desc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, police: :desc, difficulty: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :desc, police: :asc, difficulty: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :desc, police: :asc, difficulty: :asc)
								else
								end
						end
				end
			  if params[:first] == "Pedestrian(LowHigh)"
				    if params[:second] == "Difficulty(HighLow)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :desc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Difficulty(LowHigh)"
				        if params[:third] == "Security(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :asc, police: :desc)
				        elsif params[:third] == "Security(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, difficulty: :asc, police: :asc)
								else
								end
						end
				    if params[:second] == "Security(HighLow)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, police: :desc, police: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, police: :desc, police: :asc)
								else
								end
						end
				    if params[:second] == "Security(LowHigh)"
				        if params[:third] == "Difficulty(HighLow)"
										@ratings = @ratings.order(pedestrian: :asc, police: :asc, police: :desc)
				        elsif params[:third] == "Difficulty(LowHigh)"
										@ratings = @ratings.order(pedestrian: :asc, police: :asc, police: :asc)
								else
								end
						end
		    end
		 end
	end

	def testing_this
		 @skate_spots = SkateSpot.all
		 @ratings = Rating.all
	end

	def show
    @rating = Rating.find(params[:id])
    @skate_spot = SkateSpot.find_by(:id => @rating.skate_spot_id)
	end

  private

    #makes sure that the user is logged in
    def login_required
      redirect_to login_path unless logged_in?
    end

    #makes sure that the user requesting one of the above methods is actually a user that created that rating
    def users_rating
      @rating = Rating.find(params[:id])
      redirect_to skate_spot_path(@skate_spot) unless @rating.user_id == current_user.id
    end

    #filters the description to make sure that inappropriate words are not present.
    def filter 
      sex_filter = LanguageFilter::Filter.new(matchlist: :sex, exceptionlist: [], replacement: :vowels) 
      hate_filter = LanguageFilter::Filter.new(matchlist: :hate, exceptionlist: [], replacement: :vowels) 
      profanity_filter = LanguageFilter::Filter.new(matchlist: :profanity, exceptionlist: [], replacement: :vowels) 
      violence_filter = LanguageFilter::Filter.new(matchlist: :violence, exceptionlist: [], replacement: :vowels) 
      if profanity_filter.match?(@rating.description) 
        flash[:warning] = "Your post has been sanitized for the following profane language: #{profanity_filter.matched(@rating.description)}."
        @rating.description = profanity_filter.sanitize(@rating.description)
        @rating.save 
      elsif hate_filter.match?(@rating.description) 
        flash[:warning] = "Your post has been sanitized for the following hate language: #{hate_filter.matched(@rating.description)}."
        @rating.description = hate_filter.sanitize(@rating.description)
        @rating.save 
      elsif sex_filter.match?(@rating.description) 
        flash[:warning] = "Your post has been sanitized for the following sex language: #{sex_filter.matched(@rating.description)}."
        @rating.description = sex_filter.sanitize(@rating.description)
        @rating.save 
      elsif violence_filter.match?(@rating.description)
        flash[:warning] = "Your post has been sanitized for the following violent language: #{violence_filter.matched(@rating.description)}."
        @rating.description = violence_filter.sanitize(@rating.description)
        @rating.save 
      else
      end
    end
    
    #gets the specified skate_spot
    def set_skate_spot
      @skate_spot = SkateSpot.find(params[:skate_spot_id])
    end
      
    #the attributes the the rating table that are needed for create edit and update
    def rating_params
      params.require(:rating).permit(:difficulty, :police, :pedestrian, :description)
      #params.require(:rating).permit(:difficulty, :police, :pedestrian, :time, :description)
    end

end
