class Location < ActiveRecord::Base

  has_one :skate_spot

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

end
