class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
  end

  def show
    @rating = Rating.find(params[:id])
  end

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(params[:rating_params])

    if @rating.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @rating = Rating.find(params[:id])
  end

  def update
    @rating = Rating.find(params[:id])
    if @rating.update(rating_params)
      redirect_to @rating, notice: "Rating has been successfully updated!" 
    else
      render :edit
    end
  end

  def destroy
    Rating.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  private
    #def set_rating
    #  @rating = Rating.find(params[:id])
    #end

    def rating_params
      params.require(:rating).permit(:difficulty, :police, :pedestrian, :time, :description)
    end
end
