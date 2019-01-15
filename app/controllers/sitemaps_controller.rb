class SitemapsController < ApplicationController
	
	def index
		@host = "#{request.protocol}#{request.host}"
		@skate_spots = SkateSpot.all
	end

end
