class Location < ActiveRecord::Base

  has_one :skate_spot
 
  #geocoded_by :full_street_address
  #after_validation :geocode

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode

  #reverse_geocoded_by :latitude, :longitude
  #after_validation :reverse_geocode, :on => [:new, :create, :update] # auto-fetch address
  #after_validation :reverse_geocode, :update_skate_spots_edit#, :on => [:create, :edit]

  #private
  
     def full_street_address
       [address, city, state, country].compact.join(',')
     end

  #  def update_skate_spots_edit
  #    skate_spot &:edit
  #  end

end
