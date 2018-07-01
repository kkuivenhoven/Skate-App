class HashTag < ActiveRecord::Base

	serialize :event_ids, Hash
	serialize :rating_ids, Hash
	serialize :reply_ids, Hash
	serialize :skate_spot_ids, Hash
	# has_and_belongs_to_many :responses

end
