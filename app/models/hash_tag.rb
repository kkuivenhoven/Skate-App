class HashTag < ActiveRecord::Base

	serialize :reply_ids, Hash
	serialize :skate_spot_ids, Hash
	# has_and_belongs_to_many :responses

end
