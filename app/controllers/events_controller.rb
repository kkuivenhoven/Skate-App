class EventsController < ApplicationController
	  before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_skate_spot, except: [:index, :testing_this, :index_park_spot, :index_street_spot]

		def new
				@user = current_user.id
				@event = @skate_spot.events.build
		end

		def create
				@event = @skate_spot.events.create(event_params)
				@event.user_id = current_user.id
				@event.zip_code = @skate_spot.zip_code
				@event.city = @skate_spot.city
				@event.longitude = @skate_spot.longitude
				@event.latitude = @skate_spot.latitude

				noError = 0
				@messages = @event.description.gsub(/\s+/m, ' ').strip.split(" ")
				@hashtags = @messages.join(' ').scan(/#\w+\s{0}/)

				@ok = Array.new
				@messages.each do |cc_o|
					if cc_o.scan(/#\w+/).length > 0
						@ok.push(cc_o.to_s)
					else
						@ok.push(cc_o.to_s)
					end
				end

				@event.description = @ok.join(" ")


			 if @hashtags.count > 0 
					@hashtags.each do |hr|
						if HashTag.where(:name => hr).count == 0
							@ht = HashTag.new
							@ht.name = hr.to_s
							@ht.update_attribute(:reply_ids, @ht.event_ids.merge!(@event.id => @event.id))
							@ht.update_attribute(:skate_spot_ids, @ht.skate_spot_ids.merge!(@event.skate_spot_id => @event.skate_spot_id))
							if @event.save
								if @ht.save
									noError = 1
								end 
							end 
						else
							@ht = HashTag.where(:name => hr) 
							@ht.first.update_attribute(:reply_ids, @ht.first.event_ids.merge!(@event.id => @event.id))
							@ht.first.update_attribute(:skate_spot_ids, @ht.first.skate_spot_ids.merge!(@event.skate_spot_id => @event.skate_spot_id))
							if @event.save
									noError = 1
							end 
						end 
					end 
				else
					if @event.save
						noError = 1 
					end 
				end 

			if noError == 1
				flash[:success] = "Event has been successfully created!"
				redirect_to skate_spot_path(@skate_spot)
			elsif noError == 0
				flash[:danger] = "Event has been unsuccessfully created. Please try again."
				render 'new'
			end 
		end


		def edit
			@event = @skate_spot.events.find(params[:id])
		end


		def update
				@event = @skate_spot.events.find(params[:id])
				if @event.update(event_params)
						flash[:success] = "Event has been successfully updated!"
						redirect_to skate_spot_path(@skate_spot)
				else
						flash[:success] = "Event has not been updated. Please try again"
						render 'edit'
				end
		end

		def destroy
				@event = @skate_spot.events.find(params[:id])
				if @event.destroy
						flash[:success] = "Event has been successfully deleted!"
						# redirect_to skate_spot_path(@skate_spot)
						redirect_to events_path
				else
						flash[:success] = "Event has not been deleted. Please try again"
						# redirect_to skate_spot_path(@skate_spot)
						redirect_to events_path
				end
		end

		def index
				@skate_spots = SkateSpot.all.order(:name)
				@events = Event.all
		    if params[:search]
				   #	 @all_events = Event.all
			     @events = @events.search(params[:search])
					 # @event = @events.first
					 # @all_events.each do |e|
					 #	 @dist = @event.distance_from([e.latitude, e.longitude]).round(2)
					 # end
			     @time = Time.now + 60.days
			     @start = Time.now - 1.days
			     @events = @events.where(:date => @start..@time)
		    end
		end

		def show
				@event = Event.find(params[:id])
				@skate_spot = SkateSpot.find_by(:id => @event.skate_spot_id)
		end

		private

			def event_params
					params.require(:event).permit(:name, :date, :description)
			end

			def login_required
					redirect_to login_path unless logged_in?
			end

      def set_skate_spot
        @skate_spot = SkateSpot.find(params[:skate_spot_id])
      end

end
