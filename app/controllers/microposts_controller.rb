# Source: # https://www.railstutorial.org/book, Hartl Michael, 2014

class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
			@feed_items = []
      render 'static_pages/home'
    end
  end

  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  # https://www.railstutorial.org/book, Hartl Michael, 2014
	def news_feed
    if logged_in?
      @micropost  = current_user.microposts.build
      # @users = User.where(activated: true). paginate(page: params[:page], :per_page => 20).order('name')
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 10)
    end
	end
  
  private

    # https://www.railstutorial.org/book, Hartl Michael, 2014
    def micropost_params
      params.require(:micropost).permit(:content)
    end

    # https://www.railstutorial.org/book, Hartl Michael, 2014
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
