class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

	validates_presence_of :body, :conversation_id, :user_id

	def msgTime(message)
		return message.created_at.strftime("%r");
	end
		
end
