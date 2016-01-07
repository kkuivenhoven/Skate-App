class SkateSpot < ActiveRecord::Base

  belongs_to :user
  has_many :ratings
  has_one :location

end
