class Conversation < ActiveRecord::Base
	belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
	belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

	has_many :messages, dependent: :destroy

	validates_uniqueness_of :sender_id, :scope => :recipient_id

	scope :involving, -> (user) do
		where("conversations.sender_id =? OR conversations.recipient_id=?", user.id, user.id)
	end

	def self.convo_exists?(user1_id, user2_id)
		if Conversation.where(sender_id: user1_id, recipient_id: user2_id).any?
		  return Conversation.where(sender_id: user1_id, recipient_id: user2_id).first.id
		elsif Conversation.where(recipient_id: user1_id, sender_id: user2_id).any?
			return Conversation.where(recipient_id: user1_id, sender_id: user2_id).first.id
		else
			return -1
		end
	end
		

	scope :between, -> (sender_id, recipient_id) do
		where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id =? )", sender_id, recipient_id, recipient_id, sender_id)
	end

end
