class SkateSpot < ActiveRecord::Base


  belongs_to :user
  has_many :ratings
  has_one :location

  geocoded_by :complete_address
	after_validation :geocode
  #reverse_geocoded_by :latitude, :longitude

 #validates_presence_of makes sure that the user provided input for that specified attribute
  validates_presence_of :name
  validates_presence_of :zip_code
  #makes sure that the user enters in a zip_code of 5 characters
  validates :zip_code, :length => { :is => 5 }
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :country
  #makes sure that the user enters in a country of 3 characters (i.e. USA)
  validates :country, :length => { :is => 3 }

  #searches the SkateSpot DB for skate_spots with that zip_code that has been specified by the user
  def self.search(query)
    where("zip_code like ?", "%#{query}%") 
  end

	def num_and_st
		number_street = "#{number} #{street}"
		return number_street
	end

	def complete_address
		#[num_and_st, city, state, country].join(', ')
		[num_and_st, city, state, zip_code].join(', ')
	end

	def gmaps4rails_address
		return "#{complete_address}"
	end

	def get_coords
		return Geocoder.coordinates(complete_address)
	end

  def get_lat
		return get_coords[0]
	end
  def get_long
		return get_coords[1]
	end

	def set_lat_long
			@skate_spot.latitude = get_lat
			@skate_spot.longitude = get_long
  end

end
