module SkateSpotsHelper


	def material_words(skate_spot)
      if skate_spot.wood && skate_spot.concrete && skate_spot.metal
				return "Wood, Concrete, Metal"
      elsif skate_spot.wood && skate_spot.concrete
				return "Wood, Concrete"
      elsif skate_spot.wood && skate_spot.metal
				return "Wood, Metal"
      elsif skate_spot.concrete && skate_spot.metal 
				return "Concrete, Metal"
      elsif skate_spot.wood 
				return "Wooden"
      elsif skate_spot.metal
				return "Metal"
      elsif skate_spot.concrete
				return "Concrete"
      else 
				return "No material listed"
      end
	end


	def ss_size(skate_spot)
    if skate_spot.skate_spot_size 
			return "Skate spot size"
    elsif skate_spot.neighborhood_spot_size 
			return "Neighborhood spot size"
    elsif skate_spot.regional_spot_size 
			return "Regional spot size"
    else 
			return "No size listed"
    end
	end


	def ss_type(skate_spot)
		if skate_spot.transition 
			return "Transition"
		elsif skate_spot.street_plaza 
			return "Street Plaza"
		else 
			return "Not listed"
		end
	end


end
