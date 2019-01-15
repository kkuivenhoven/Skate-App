class SitemapsController < ApplicationController
	
	def index
    if !logged_in?
			@host = "#{request.protocol}#{request.host}"
			@skate_spots = SkateSpot.all
		end
	end

end
