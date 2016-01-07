#Sources:
#http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/
#https://www.railstutorial.org/book, Hartl Michael, 2014

class RatingsController < ApplicationController
  before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
  #first, obtain the skate_spot using set_skate_spot
  before_action :set_skate_spot
  before_action :users_rating, only: [:edit, :update, :destroy]

  #GET /skate_spots/:skate_spot_id/ratings
  def index
    #get all ratings of this skate_spot
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
    @rating = @skate_spot.ratings.create(rating_params)
    @rating.user_id = current_user.id
    if @rating.save
      #redirect_to :action => 'index'
      redirect_to skate_spot_path(@skate_spot)
    else
      render :action => 'new'
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
      render :edit
    end
  end

  #DELETE /skate_spots/:skate_spot_id/ratings/1
  def destroy
    @rating = @skate_spot.ratings.find(params[:id])
    @rating.destroy
    redirect_to :action => 'index'
  end

  private

    def login_required
      redirect_to login_path unless logged_in?
    end

    def users_rating
        @rating = Rating.find(params[:id])
        redirect_to skate_spot_path(@skate_spot) unless @rating.user_id == current_user.id
     end

    
    def set_skate_spot
      @skate_spot = SkateSpot.find(params[:skate_spot_id])
    end
      
    def rating_params
      params.require(:rating).permit(:difficulty, :police, :pedestrian, :time, :description)
    end
end
