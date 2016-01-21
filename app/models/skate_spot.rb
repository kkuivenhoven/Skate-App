class SkateSpot < ActiveRecord::Base

  belongs_to :user
  has_many :ratings
  has_one :location

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

end
