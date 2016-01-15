class SkateSpot < ActiveRecord::Base

  belongs_to :user
  has_many :ratings
  has_one :location


  #returns skatespots whose names contain >=1 words that form the query
  def self.search(query)
    #where(:name, query) -> returns an exact match of the query
    ##where("name like ?", "%#{query}%") 
    where("zip_code like ?", "%#{query}%") 
  end

end
