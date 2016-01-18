class SkateSpot < ActiveRecord::Base

  belongs_to :user
  has_many :ratings
  has_one :location

  validates_presence_of :name
  validates_presence_of :zip_code
  validates :zip_code, :length => { :is => 5 }
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :country
  validates :country, :length => { :is => 3 }

  def self.search(query)
    where("zip_code like ?", "%#{query}%") 
  end

end
