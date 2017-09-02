# Sources:
# https://www.railstutorial.org/book/user_microposts#cha-user_microposts
#
class Micropost < ActiveRecord::Base
  belongs_to :user
	# belongs_to :skate_spot
	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }
end
