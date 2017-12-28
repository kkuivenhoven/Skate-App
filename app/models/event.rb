class Event < ActiveRecord::Base
  belongs_to :skate_spot  

  def self.search(search)
    where("zip_code LIKE ? OR city LIKE ?", "%#{search}%", "%#{search}%") 
  end

	def eventDate_LB
		time = date.localtime.strftime "At %l:%M %p"
		lineBreak = ", on<br>"
		first = time + lineBreak
		second = date.localtime.strftime "%B %e, %Y"
		all = [first, second].join('').html_safe
		return all
	end
	

end
