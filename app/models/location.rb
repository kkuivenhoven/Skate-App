#Resources:
#http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#format

class Location < ActiveRecord::Base

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode

  def full_street_address
    [address, city, state, country].compact.join(',')
  end

end
