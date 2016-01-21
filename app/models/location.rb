#Resources:
#http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#format

class Location < ActiveRecord::Base

  #geocode by the :address attribute of Location Table
  geocoded_by :address
  #given lat & long coordinates, geocode the address of those coordinates
  reverse_geocoded_by :latitude, :longitude
  #after necessary validations for lat and long and address, geocode or reverse_geocode based on what attributes were given
  after_validation :geocode, :reverse_geocode

#  def full_street_address
#    [address, city, state, country].compact.join(',')
#  end

end
