class Event < ActiveRecord::Base
  belongs_to :skate_spot  

  def self.search(search)
    where("zip_code LIKE ? OR city LIKE ?", "%#{search}%", "%#{search}%") 
  end

end
