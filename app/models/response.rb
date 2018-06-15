class Response < ActiveRecord::Base
		belongs_to :rating
		belongs_to :user
		# has_and_belongs_to_many :hash_tags
end
