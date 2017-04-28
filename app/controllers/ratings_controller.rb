#Sources:
#http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/
#https://www.railstutorial.org/book, Hartl Michael, 2014
#https://github.com/chrisvfritz/language_filter

class RatingsController < ApplicationController
  before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
  #first, obtain the skate_spot using set_skate_spot
  before_action :set_skate_spot, except: [:index]
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

	def index
		 @skate_spots = SkateSpot.all
		 @ratings = Rating.all
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
