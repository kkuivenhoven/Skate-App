class StaticPagesController < ApplicationController

  #the homepage of the app
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

	def skate_links
  end

end
