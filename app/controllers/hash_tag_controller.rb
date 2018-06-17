class HashTagController < ApplicationController

  def index
  end

  def show
		if !params[:id].nil?
			@hashtag = HashTag.where(:id => params[:id]).first
		elsif !params[:name].nil?
			@hashtag = HashTag.where(:name => params[:name]).first
		end
		if @hashtag.reply_ids.any?
			@response = Response.where(:id => @hashtag.reply_ids.first[0])
			@responses = Response.find_each(:ids => @hashtag.reply_ids.keys)
			@ok = Response.where(id: @hashtag.reply_ids.keys).paginate(page: params[:page])
		end
		# if @responses.nil?
	# 		@responses = Rating.find_each(:ids => @hashtag.rating_ids.keys)
	# 	end

  end

end
