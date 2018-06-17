class HashTagController < ApplicationController

  def index
  end

  def show
		if !params[:id].nil?
			@hashtag = HashTag.where(:id => params[:id]).first
		elsif !params[:name].nil?
			@hashtag = HashTag.where(:name => params[:name]).first
		end
		@patinar_ids = Array.new
		if @hashtag.reply_ids.any?
			@response = Response.where(:id => @hashtag.reply_ids.first[0])
			@responses = Response.find_each(:ids => @hashtag.reply_ids.keys)
			@ok = Response.where(id: @hashtag.reply_ids.keys).paginate(page: params[:page])
			@ok.each do |o|
				@r_items = Rating.where(id: o.rating_id)
				@s_s = SkateSpot.where(id:@r_items.first.skate_spot_id)
				@patinar_ids.push(@s_s.first.id)
			end
		end
		if @hashtag.rating_ids.any?
			# @response = Rating.where(:id => @hashtag.rating_ids.first[0])
			@la_resp = Rating.where(:id => @hashtag.rating_ids.first[0])
			# @responses = Rating.find_each(:ids => @hashtag.rating_ids.keys)
			@la_resps = Rating.find_each(:ids => @hashtag.rating_ids.keys)
			# @ok = Rating.where(id: @hashtag.rating_ids.keys).paginate(page: params[:page])
			@la_ok = Rating.where(id: @hashtag.rating_ids.keys).paginate(page: params[:page])
			@la_ok.each do |o|
				@rating_i = o
				@patinar_ids.push(o.skate_spot_id)
			end
		end
		@patinar_ids = @patinar_ids.uniq
		# if @responses.nil?
	# 		@responses = Rating.find_each(:ids => @hashtag.rating_ids.keys)
	# 	end
		@all_ss = SkateSpot.where(id: @patinar_ids)

  end

end
