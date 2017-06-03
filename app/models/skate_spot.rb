class SkateSpot < ActiveRecord::Base

  belongs_to :user
  has_many :ratings
  has_one :location
	has_many :microposts, dependent: :destroy

  #geocoded_by :complete_address
  geocoded_by :gmaps4rails_address
	after_validation :geocode
  #reverse_geocoded_by :latitude, :longitude
	#acts_as_gmappable

 #validates_presence_of makes sure that the user provided input for that specified attribute
  validates_presence_of :name
  #validates_presence_of :zip_code, :if => :create
  ##makes sure that the user enters in a zip_code of 5 characters
  #validates :zip_code, :length => { :is => 5 }, :if => :create
  #validates_presence_of :street, :if => :create
  #validates_presence_of :city, :if => :create
  #validates_presence_of :state, :if => :create
  #validates_presence_of :country, :on => :create
  ##makes sure that the user enters in a country of 3 characters (i.e. USA)
  #validates :country, :length => { :is => 3 }, :on => :create

  #searches the SkateSpot DB for skate_spots with that zip_code that has been specified by the user
  #def self.search(query)
  #  where("zip_code like ?", "%#{query}%") 
  #end

  def self.search(search)
    where("name LIKE ? OR street LIKE ? OR city LIKE ? OR zip_code LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
  end

	def num_and_st
		number_street = "#{number} #{street}"
		return number_street
	end

	def basic_address
		[num_and_st, city].join(', ')
	end

	def just_city
		return "#{city}"
	end

	def complete_address
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
