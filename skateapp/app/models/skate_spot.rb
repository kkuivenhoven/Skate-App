class SkateSpot < ActiveRecord::Base

  has_many :ratings
  has_one :location

end
