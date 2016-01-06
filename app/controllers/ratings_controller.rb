#Sources:
#http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/

class RatingsController < ApplicationController
  #first, obtain the skate_spot using set_skate_spot
  before_action :set_skate_spot

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
    if @rating.save
      redirect_to :action => 'index'
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
    #fetch the rating
    @rating = @skate_spot.ratings.find(params[:id])
    if @rating.update(rating_params)
      redirect_to([@rating.skate_spot, @rating], :notice => 'Rating has been successfully updated!') 
    else
      render :edit
    end
  end

  #DELETE /skate_spots/:skate_spot_id/ratings/1
  def destroy
    #fetch the rating
    @rating = @skate_spot.ratings.find(params[:id])
    @rating.destroy
    redirect_to :action => 'index'
  end

  private
    def set_skate_spot
      @skate_spot = SkateSpot.find(params[:skate_spot_id])
    end
      
    def rating_params
      params.require(:rating).permit(:difficulty, :police, :pedestrian, :time, :description)
    end
end
