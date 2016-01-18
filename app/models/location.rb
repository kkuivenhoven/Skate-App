class Location < ActiveRecord::Base

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode

  def full_street_address
    [address, city, state, country].compact.join(',')
  end

end
