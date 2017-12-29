# Sources: 
# http://guides.rubyonrails.org/active_record_validations.html#numericality
# http://railscasts.com/episodes/253-carrierwave-file-uploads

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :skate_spot  
	has_many :responses

#	attr_accessor :image, :remote_image_url
	mount_uploader :image, ImageUploader
 
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

  def self.ratings_sort(first_p, second_p, third_p, useSort)
		first_p = first_p.split('(')
		first_p[1] = first_p[1].chop
		second_p = second_p.split('(')
		second_p[1] = second_p[1].chop
		third_p = third_p.split('(')
		third_p[1] = third_p[1].chop
    @equals = { "Difficulty" => "avgDiff", "Security" => "avgSec", "Pedestrian" => "avgPed" }
		if first_p[1] == "LowHigh"
			if second_p[1] == "LowHigh"
				if third_p[1] == "LowHigh"
					@sorted = useSort.sort_by{ |k,v| [v[@equals[first_p[0]]], v[@equals[second_p[0]]], v[@equals[third_p[0]]]] }
				elsif third_p[1] == "HighLow"
					@sorted = useSort.sort_by{ |k,v| [v[@equals[first_p[0]]], v[@equals[second_p[0]]], -v[@equals[third_p[0]]]] }
				end
			elsif second_p[1] == "HighLow"
				if third_p[1] == "LowHigh"
					@sorted = useSort.sort_by{ |k,v| [v[@equals[first_p[0]]], -v[@equals[second_p[0]]], v[@equals[third_p[0]]]] }
				elsif third_p[1] == "HighLow"
					@sorted = useSort.sort_by{ |k,v| [v[@equals[first_p[0]]], -v[@equals[second_p[0]]], -v[@equals[third_p[0]]]] }
				end
			end
		elsif first_p[1] == "HighLow"
			if second_p[1] == "LowHigh"
				if third_p[1] == "LowHigh"
					@sorted = useSort.sort_by{ |k,v| [-v[@equals[first_p[0]]], v[@equals[second_p[0]]], v[@equals[third_p[0]]]] }
				elsif third_p[1] == "HighLow"
					@sorted = useSort.sort_by{ |k,v| [-v[@equals[first_p[0]]], v[@equals[second_p[0]]], -v[@equals[third_p[0]]]] }
				end
			elsif second_p[1] == "HighLow"
				if third_p[1] == "LowHigh"
					@sorted = useSort.sort_by{ |k,v| [-v[@equals[first_p[0]]], -v[@equals[second_p[0]]], v[@equals[third_p[0]]]] }
				elsif third_p[1] == "HighLow"
					@sorted = useSort.sort_by{ |k,v| [-v[@equals[first_p[0]]], -v[@equals[second_p[0]]], -v[@equals[third_p[0]]]] }
				end
			end
		end
		return @sorted
  end



end
