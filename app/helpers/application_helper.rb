module ApplicationHelper
	
	def getAllUsers
		# @allUsers = User.all
		User.all
	end

	def curUser_convs
		if logged_in?
			Conversation.where("(sender_id = ?) OR (recipient_id = ?)", current_user.id, current_user.id)
		end
	end

	def getUser_chat(convo)
		if current_user.id == convo.sender_id
			return convo.recipient
		else
			return convo.sender
		end
	end
		
		
end
