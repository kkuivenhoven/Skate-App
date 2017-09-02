#Sources: 
#http://guides.rubyonrails.org/active_record_validations.html#numericality

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :skate_spot  
	has_many :responses
 
  #validates_presence_of makes sure that the user has provided input for that specified attribute
  #validates_numericality_of makes sure that the user has provided numbers for input that are between 0 and 10
  validates_presence_of :difficulty
  validates_numericality_of :difficulty, numericality: { only_integer: true }
  validates_numericality_of :difficulty, :less_than_or_equal_to => 10
  validates_numericality_of :difficulty, :greater_than_or_equal_to => 0

  validates_presence_of :police
  validates_numericality_of :police, numericality: { only_integer: true }
  validates_numericality_of :police, :less_than_or_equal_to => 10
  validates_numericality_of :police, :greater_than_or_equal_to => 0

  validates_presence_of :pedestrian
  validates_numericality_of :pedestrian, numericality: { only_integer: true }
  validates_numericality_of :pedestrian, :less_than_or_equal_to => 10
  validates_numericality_of :pedestrian, :greater_than_or_equal_to => 0

  validates_presence_of :description
  validates :description, length: { minimum: 4 }
  #the above makes sure that the user entered in a description of at least 4
	

  def self.search(search)
    where("description LIKE ?", "%#{search}%") 
  end


end
