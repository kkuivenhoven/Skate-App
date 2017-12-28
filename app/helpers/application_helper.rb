module ApplicationHelper

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

end
