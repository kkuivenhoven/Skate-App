class HashTagController < ApplicationController

  def index
  end

  def show
		@hashtag = HashTag.where(:id => params[:id]).first
		@response = Response.where(:id => @hashtag.reply_ids.first[0])
		@responses = Response.find_each(:ids => @hashtag.reply_ids.keys)
		@ok = Response.where(id: @hashtag.reply_ids.keys).paginate(page: params[:page])
  end

end
