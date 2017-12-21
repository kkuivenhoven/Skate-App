class MessagesController < ApplicationController
	
	def create
		@conversation = Conversation.find(params[:conversation_id])
		# @message = @conversation.messages.build(message_params)
		@message = @conversation.messages.create(message_params)
		@message.user_id = current_user.id
		# @message.save!
		if @message.save!
		else
			flash[:danger] = "Your message was not sent. Please try again."
		end
		# if logged_in?
	  # 	@the_user = current_user
		# end

		@path = conversation_path(@conversation)
	end

	private
		
		def message_params
			params.require(:message).permit(:body)
		end

end
