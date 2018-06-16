#Sources:
#http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/
#https://www.railstutorial.org/book, Hartl Michael, 2014
#https://github.com/chrisvfritz/language_filter

class RatingsController < ApplicationController
  before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
  #first, obtain the skate_spot using set_skate_spot
  before_action :set_skate_spot, except: [:index, :testing_this, :index_park_spot, :index_street_spot, :reply, :delete_reply]
  before_action :users_rating, only: [:edit, :update, :destroy]
  after_action :filter, only: [:create] 

  #GET /skate_spots/:skate_spot_id/ratings/new
  def new
		#@user = User.find_by(id: params[:user_id])
		@user = current_user.id
    #build a new rating
    @rating = @skate_spot.ratings.build
  end


  #POST /skate_spots/:skate_spot_id/ratings
  def create
    #create the rating
    @rating = @skate_spot.ratings.create(rating_params)
    @rating.user_id = current_user.id
	
		noError = 0
		@messages = @rating.description.gsub(/\s+/m, ' ').strip.split(" ")
		@hashtags = @messages.join.scan(/#\w+/)
		@hashtags.each do |hr|
			if HashTag.where(:name => hr).count == 0
				@ht = HashTag.new
				@ht.name = hr.to_s
				@ht.update_attribute(:reply_ids, @ht.reply_ids.merge!(@rating.id => @rating.id))
				@ht.update_attribute(:skate_spot_ids, @ht.skate_spot_ids.merge!(@rating.skate_spot_id => @rating.skate_spot_id))
				if @rating.save
					if @ht.save
						noError = 1
						# flash[:success] = "Rating has been successfully created!"
						# redirect_to skate_spot_path(@skate_spot)
					# else
						# flash[:danger] = "Rating has been unsuccessfully created. Please try again."
						# render 'new'
					end
				end
			else
				@ht = HashTag.where(:name => hr)
				@ht.first.update_attribute(:reply_ids, @ht.first.reply_ids.merge!(@rating.id => @rating.id))
				@ht.first.update_attribute(:skate_spot_ids, @ht.first.skate_spot_ids.merge!(@rating.skate_spot_id => @rating.skate_spot_id))
				if @rating.save
					noError = 1
					# flash[:success] = "Rating has been successfully created!"
					# redirect_to skate_spot_path(@skate_spot)
				# else
					# flash[:danger] = "Rating has been unsuccessfully created. Please try again."
					# render 'new'
				end
			end
		end
    if noError == 1
      flash[:success] = "Rating has been successfully created!"
      redirect_to skate_spot_path(@skate_spot)
    elsif noError == 0
      flash[:danger] = "Rating has been unsuccessfully created. Please try again."
      render 'new'
    end
=begin
    if @rating.save
      flash[:success] = "Rating has been successfully created!"
      redirect_to skate_spot_path(@skate_spot)
    else
      flash[:danger] = "Rating has been unsuccessfully created. Please try again."
      render 'new'
    end
=end
  end



  #GET /skate_spots/:skate_spot_id/ratings/:id/edit
  def edit
    #fetch the rating 
    @rating = @skate_spot.ratings.find(params[:id])
  end

  #update the rating
  #PUT /skate_spots/:skate_spot_id/ratings/:id
  def update
    @rating = @skate_spot.ratings.find(params[:id])
    if @rating.update(rating_params)
      flash[:success] = "Rating has been successfully updated!"
      redirect_to skate_spot_path(@skate_spot)
      #redirect_to([@rating.skate_spot, @rating], :notice => 'Rating has been successfully updated!') 
    else
      flash[:danger] = "Rating has been unsuccesfully updated. Please try again."
      redirect_to skate_spot_path(@skate_spot)
    end
  end

  #destroy the specified rating
  #DELETE /skate_spots/:skate_spot_id/ratings/1
  def destroy
    @rating = @skate_spot.ratings.find(params[:id])
    if @rating.destroy
      flash[:success] = "Rating has been successfully deleted!"
      redirect_to skate_spot_path(@skate_spot)
    else
      flash[:danger] = "Deletion unsuccessful. Please try again."
      redirect_to skate_spot_path(@skate_spot)
    end
  end


	def index
		 @skate_spots = SkateSpot.all
		 if params[:street] == "1"
			 @ratings = Rating.joins(:skate_spot).where(skate_spots: {street_spot: true})
		 elsif params[:park] == "1"
			 @ratings = Rating.joins(:skate_spot).where(skate_spots: {park_spot: true})
		 else
			 @ratings = Rating.all
		 end
		 @grouped = @ratings.group_by(&:skate_spot_id)

	 	 @useSort = Hash.new
		 @forSort = @ratings.group_by(&:skate_spot_id)
     @forSort.each do |k,v|
				@ss = SkateSpot.find(k)
				@tmp = Hash.new
				@tmp["avgDiff"] = ("%.2f" % (@ss.ratings.average(:difficulty).truncate(2))).to_f
				@tmp["avgSec"] = ("%.2f" % (@ss.ratings.average(:police).truncate(2))).to_f
				@tmp["avgPed"] = ("%.2f" % (@ss.ratings.average(:pedestrian).truncate(2))).to_f
				@useSort[k] = @tmp	
		 end

		 # if params[:commit] == "Search"
		 if params[:commit] == "Filter"
				@sorted = @ratings.ratings_sort(params[:first], params[:second], params[:third], @useSort)
				@orderedKeys = @sorted.collect {|ind| ind[0]}
				@sortedRatings = @forSort.sort_by{|k,_| @orderedKeys.index(k)}.to_h
     else
        @sortedRatings = @ratings.group_by(&:skate_spot_id)
     end
	end

	def show
    @rating = Rating.find(params[:id])
    @skate_spot = SkateSpot.find_by(:id => @rating.skate_spot_id)
	end

	def reply
    @rating = Rating.find(params[:id])
		@response = @rating.responses.create(response_params)
		@response.user_id = current_user.id
		@response.rating_id = @rating.id
		@user = User.find_by(id: params[:user_id])
		# @hashtag = HashTag.new

		@messages = @response.message.gsub(/\s+/m, ' ').strip.split(" ")
		@hashtags = @messages.join.scan(/#\w+/)

		@hashtags.each do |hr|
			if HashTag.where(:name => hr).count == 0
				@ht = HashTag.new
				@ht.name = hr.to_s
				@ht.update_attribute(:reply_ids, @ht.reply_ids.merge!(@response.id => @response.id))
				@ht.update_attribute(:skate_spot_ids, @ht.skate_spot_ids.merge!(@rating.skate_spot_id => @rating.skate_spot_id))
				if @response.save
					if @ht.save
						flash[:success] = "Response successful"
					else
						flash[:danger] = "Response unsuccessful"
					end
				end
			else
				@ht = HashTag.where(:name => hr)
				@ht.first.update_attribute(:reply_ids, @ht.first.reply_ids.merge!(@response.id => @response.id))
				@ht.first.update_attribute(:skate_spot_ids, @ht.first.skate_spot_ids.merge!(@rating.skate_spot_id => @rating.skate_spot_id))
				if @response.save
					flash[:success] = "Response successful"
					# redirect_to @user
				else
					flash[:danger] = "Response unsuccessful"
					# redirect_to @user
				end
			end
		end

		redirect_to @user


=begin
		@hashtag = @response.message.scan(/#\w+/).flatten	
		if HashTag.where(:name => @hashtag[0].to_s).count == 0
			@ht = HashTag.new
				byebug
			@ht.name = @hashtag[0].to_s
			# @ht.update_attribute(:reply_ids, @ht.reply_ids.merge!(@response.id => params[:reply_id]))
			@ht.update_attribute(:reply_ids, @ht.reply_ids.merge!(@response.id => @response.id))
			@ht.update_attribute(:skate_spot_ids, @ht.skate_spot_ids.merge!(@rating.skate_spot_id => @rating.skate_spot_id))
			if @response.save
				if @ht.save
					flash[:success] = "Response successful"
					redirect_to @user
				else
					flash[:danger] = "Response unsuccessful"
					redirect_to @user
				end
			end
		else
			@ht = HashTag.where(:name => @hashtag[0].to_s)
			@ht.first.update_attribute(:reply_ids, @ht.first.reply_ids.merge!(@response.id => @response.id))
			@ht.first.update_attribute(:skate_spot_ids, @ht.first.skate_spot_ids.merge!(@rating.skate_spot_id => @rating.skate_spot_id))
			if @response.save
				flash[:success] = "Response successful"
				redirect_to @user
			else
				flash[:danger] = "Response unsuccessful"
				redirect_to @user
			end
# byebug
			# @ht.update_attribute(:reply_ids, @ht.reply_ids.merge!(@response.id => @response.id))
		end
=end



=begin
    if @response.save
			if @ht.save
				flash[:success] = "@ht successful"
				redirect_to @user
			else
				flash[:danger] = "@ht unsuccessful"
				redirect_to @user
			end
    else
      flash[:danger] = "Response has been unsuccessfully created. Please try again."
		  redirect_to @user
    end
=end
	end

	def delete_reply
		@rating = Rating.find(params[:rating_id])
		@user = User.find_by(id: params[:user_id])
    @response = @rating.responses.find(params[:resp_id])
    if @response.destroy
      flash[:success] = "Response has been successfully deleted!"
		  redirect_to @user
    else
      flash[:danger] = "Deletion unsuccessful. Please try again."
		  redirect_to @user
    end
	end

  private

    #makes sure that the user is logged in
    def login_required
      redirect_to login_path unless logged_in?
    end

    #makes sure that the user requesting one of the above methods is actually a user that created that rating
    def users_rating
      @rating = Rating.find(params[:id])
      redirect_to skate_spot_path(@skate_spot) unless @rating.user_id == current_user.id
    end

    #filters the description to make sure that inappropriate words are not present.
    def filter 
      hate_filter = LanguageFilter::Filter.new(matchlist: :hate, exceptionlist: [], replacement: :vowels) 
      profanity_filter = LanguageFilter::Filter.new(matchlist: :profanity, exceptionlist: [], replacement: :vowels) 
      violence_filter = LanguageFilter::Filter.new(matchlist: :violence, exceptionlist: [], replacement: :vowels) 
      if profanity_filter.match?(@rating.description) 
        flash[:warning] = "Your post has been sanitized for the following profane language: #{profanity_filter.matched(@rating.description)}."
        @rating.description = profanity_filter.sanitize(@rating.description)
        @rating.save 
      elsif hate_filter.match?(@rating.description) 
        flash[:warning] = "Your post has been sanitized for the following hate language: #{hate_filter.matched(@rating.description)}."
        @rating.description = hate_filter.sanitize(@rating.description)
        @rating.save 
      elsif violence_filter.match?(@rating.description)
        flash[:warning] = "Your post has been sanitized for the following violent language: #{violence_filter.matched(@rating.description)}."
        @rating.description = violence_filter.sanitize(@rating.description)
        @rating.save 
      else
      end
    end
    
    #gets the specified skate_spot
    def set_skate_spot
      @skate_spot = SkateSpot.find(params[:skate_spot_id])
    end
      
    #the attributes the the rating table that are needed for create edit and update
    def rating_params
      params.require(:rating).permit(:difficulty, :police, :pedestrian, :description, :image)
      # params.require(:rating).permit(:difficulty, :police, :pedestrian, :description)
      # params.require(:rating).permit(:difficulty, :police, :pedestrian, :time, :description)
    end

    def response_params
      params.require(:response).permit(:message)
    end


end
