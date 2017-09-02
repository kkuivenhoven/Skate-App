class StaticPagesController < ApplicationController

  #the homepage of the app
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @rating_items = current_user.rating_feed.paginate(page: params[:page])
			# @events = Event.all
			@time = Time.now + 60.days
			@start = Time.now - 1.days
			# @events = Event.where(:date => @start..@time)
			@events = Event.all
    end
  end

  def help
  end

	def skate_links
  end

	def testing
	end

end
