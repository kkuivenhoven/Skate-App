module MessagesHelper

	def self_or_other(message)
		# message.user == current_user ? "self" : "other"
		if message.user == current_user 
			return "self"
		else
			return "other"
		end
	end

	def message_interlocutor(message)
		# message.user == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
		if message.user == message.conversation.sender
			return message.conversation.sender
		else
			return message.conversation.recipient
		end
	end

end
