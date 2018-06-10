# Sources/Tutorials/Inspriation:
# http://railscasts.com/episodes/253-carrierwave-file-uploads
# 	• used as a reference for getting image of specified rating 
# 			(i.e. getImg(rating) method)

module ApplicationHelper

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
