module UsersHelper

# Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end


	def UR_diff(s_rate)
		return s_rate.ratings.average(:difficulty).truncate(2)
	end

	def UR_sec(s_rate)
		return s_rate.ratings.average(:police).truncate(2)
	end

	def UR_ped(s_rate)
		return s_rate.ratings.average(:pedestrian).truncate(2)
	end

	def UR_parkStreet(s_rate)
		if @s_rate.park_spot
				return "Park spot"
		elsif @s_rate.street_spot
				return "Street spot"
		else 
				return "Type of spot not indicated"
		end 
	end


end

