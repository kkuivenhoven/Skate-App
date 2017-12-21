class ConversationsController < ApplicationController

	layout false

	def create 
=begin
		if Conversation.between(params[:sender_id],params[:recipient_id]).present?
			@conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
		else
			@conversation = Conversation.create!(conversation_params)
		end
=end
		convExists = 0
    if Conversation.where(sender_id: params[:sender_id], recipient_id: params[:recipient_id]).any?
			convExists = 1
    # if Conversation.where("(#{@conversations.sender_id} = ? AND #{@conversations.recipient_id} = ?) OR (#{@conversations.sender_id} ? AND #{@conversations.recipient_id} = ?)", params[:sender_id], params[:recipient_id], params[:recipient_id], params[:sender_id]).any?
    #works if Conversation.where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)", params[:sender_id], params[:recipient_id], params[:recipient_id], params[:sender_id]).any?
			# sender_id: params[:sender_id], recipient_id: params[:recipient_id]).any?
      # @conversation = Conversation.where(sender_id: params[:sender_id], recipient_id: params[:recipient_id]).first.id
      # @conversation = Conversation.where(sender_id: params[:sender_id], recipient_id: params[:recipient_id]).first
			# @conversation = Conversation.where("(@conversations.sender_id = ? AND @conversations.recipient_id = ?) OR (@conversations.sender_id ? AND @conversations.recipient_id = ?)", params[:sender_id], params[:recipient_id], params[:recipient_id], params[:sender_id]).first
			#works @conversation = Conversation.where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)", params[:sender_id], params[:recipient_id], params[:recipient_id], params[:sender_id]).first
    # elsif Conversation.where(recipient_id: params[:recipient_id], sender_id: params[:sender_id]).any?
    elsif Conversation.where(sender_id: params[:recipient_id], recipient_id: params[:sender_id]).any?
			convExists = 1
      # @conversation = Conversation.where(recipient_id: params[:recipient_id], sender_id: params[:sender_id]).first.id
      # @conversation = Conversation.where(recipient_id: params[:recipient_id], sender_id: params[:sender_id]).first
      # @conversation = Conversation.where(sender_id: params[:recipient_id], recipient_id: params[:sender_id]).first
		end
    if convExists == 1
			@conversation = Conversation.where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)", params[:sender_id], params[:recipient_id], params[:recipient_id], params[:sender_id]).first
    else
			@conversation = Conversation.create!(conversation_params)
		end

		render json: { conversation_id: @conversation.id }
	end

	def show
		@conversation = Conversation.find(params[:id])
		# @reciever = interlocutor(@conversation)
		if current_user == @conversation.recipient
			# means if cur_user started conversation/hit send message button
			# but cur_user is not stored as sender but stored as recipient
			# need to indicate that whomever is stored as sender is now the reciever
			@reciever = @conversation.sender
		else
			# indicates that cur_user started conversation/hit send message button
			# and cur_user is stored as recipient so can indicate that the
			# stored recipient is the reciever
			@reciever = @conversation.recipient
		end
		@messages = @conversation.messages
		@message = Message.new
	end

	private 
		def conversation_params
			params.permit(:sender_id, :recipient_id)
		end

		def interlocutor(conversation)
			current_user == conversation.recipient ? conversation.sender : conversation.recipient
		end

end
