#Sources:
#http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/
#https://www.railstutorial.org/book, Hartl Michael, 2014
#https://github.com/chrisvfritz/language_filter

class RatingsController < ApplicationController
  before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
  #first, obtain the skate_spot using set_skate_spot
  before_action :set_skate_spot
  before_action :users_rating, only: [:edit, :update, :destroy]
  after_action :filter, only: [:create]

  #GET /skate_spots/:skate_spot_id/ratings
  def index
    @ratings = @skate_spot.ratings
  end

  #GET /skate_spots/:skate_spot_id/ratings/:id
  def show
    #fetch the rating 
    @rating = @skate_spot.ratings.find(params[:id])
  end

  #GET /skate_spots/:skate_spot_id/ratings/new
  def new
    #build a new rating
    @rating = @skate_spot.ratings.build
  end

  #POST /skate_spots/:skate_spot_id/ratings
  def create
    #create the rating
    #@rating = @skate_spot.ratings.create(params[:rating_params])
    @rating = @skate_spot.ratings.create(rating_params)
    @rating.user_id = current_user.id
    if @rating.save
      flash[:success] = "Rating has been successfully created!"
      redirect_to skate_spot_path(@skate_spot)
    else
      flash[:danger] = "Rating has been unsuccessfully created. Please try again."
      render 'new'
      #redirect_to new_skate_spot_rating_path(@skate_spot)
    end
  end

  #GET /skate_spots/:skate_spot_id/ratings/:id/edit
  def edit
    #fetch the rating 
    @rating = @skate_spot.ratings.find(params[:id])
  end

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

  private

    def login_required
      redirect_to login_path unless logged_in?
    end

    def users_rating
      @rating = Rating.find(params[:id])
      redirect_to skate_spot_path(@skate_spot) unless @rating.user_id == current_user.id
    end

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
    
    def set_skate_spot
      @skate_spot = SkateSpot.find(params[:skate_spot_id])
    end
      
    def rating_params
      params.require(:rating).permit(:difficulty, :police, :pedestrian, :time, :description)
    end

    def set_skate_spot
      @skate_spot = SkateSpot.find(params[:skate_spot_id])
    end
      
    def rating_params
      params.require(:rating).permit(:difficulty, :police, :pedestrian, :description)
      #params.require(:rating).permit(:difficulty, :police, :pedestrian, :time, :description)
    end

end
