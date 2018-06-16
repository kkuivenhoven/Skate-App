# Sources/Tutorials/Inspriation:
# http://railscasts.com/episodes/253-carrierwave-file-uploads
# 	• used as a reference for getting image of specified rating 
# 			(i.e. getImg(rating) method)

module ApplicationHelper
	
	def mappedTags
		@tags = HashTag.all.map{ |c| [c.name, c.reply_ids]}.to_h
		return @tags
	end

	def collectHT
		@grpd_HT = HashTag.all.group_by(&:name)
		return @grpd_HT
	end

	def getRating(id)
		@rating_items = Rating.where(id: id)
		@skate_spot = SkateSpot.where(id: @rating_items.first.skate_spot_id)
		# return Rating.where(id: id)
		return @rating_items
	end
	
	def retrieveSpots(ids)
		@all_spots = SkateSpot.where(:id => ids)
		return @all_spots
	end

	def getMsg(resp)
		# if HashTag.where(:name => resp.to_s).count > 0
		if HashTag.where("name like ?", resp).count > 0
			# @ht = HashTag.where(:name => resp)
			@ht = HashTag.where("name like ?", resp)
		else
			return
		end
	end

	def getEvents
		@events = Event.all
	end

	def getOrganizations
		@organizations = Organization.all.order(:approved)
	end

	def UV_1(skate_spot)
		total = skate_spot.user_votes.select{|key, hash| hash["1"] == "1" }.count
		all = total.to_s + "&nbsp;"
		return all.html_safe
	end

	def UV_0(skate_spot)
		total = skate_spot.user_votes.select{|key, hash| hash["0"] == "0" }.count
		all = total.to_s + "&nbsp;"
		return all.html_safe
	end

	def getImg(rating)
		if rating.image.present?
			# return rating.image_url(:large_thumb)
			return rating.image_url(:thumb)
		end
	end

	def org_approved(org)
		if org.approved == false
			val = "<span style='color: #9b0101';>" + org.approved.to_s.capitalize + "</span>"
		else
			val = org.approved.to_s.capitalize
		end
		return val.html_safe
	end

end
