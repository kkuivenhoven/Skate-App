# Sources/resources:
# https://stackoverflow.com/questions/11806004/rails-activerecord-db-sort-operation-case-insensitive

class StaticPagesController < ApplicationController

	def letsencrypt
		render text: "#{params[:id]}.9l4va-Uy7XrFPGS51hnH7HwkF2nn3XhwfuR8U5ylxIM"
	end

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

  def contact
  end

	def skate_links
		# @organizations = Organization.where(:approved => true).order(name: :asc)
		@organizations = Organization.where(:approved => true).order("lower(name) ASC").all
  end

	def testing
	end

end
