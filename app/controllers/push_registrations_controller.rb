class PushRegistrationsController < ApplicationController

	def create
		puts params[:subscription]
		User.find_or_create_by(push_sub: params[:subscription])
	end

end
