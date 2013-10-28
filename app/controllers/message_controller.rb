class MessageController < ApplicationController
    before_filter :authenticate_user!

    def new
        @user = User.find params[:id]
        @message = Message.new
    end

    def create
        @user = User.find params[:id]
        @message = Message.new new_message_params
        if @message.valid?
            @message.sender = current_user
            @message.recipient = @user
            @message.is_conversation = true
            @message.unread_by_sender = false
            @message.save
            redirect_to user_show_path(@user)
        else
            render :new
        end
    end

    def inbox
        @messages = Message.where(:is_conversation => true).where(
            "recipient_id = ? or (sender_id = ? and has_conversations = ?)",
            current_user.id, current_user.id, true).order("created_at DESC")
    end

    def sent
        @messages = Message.where(
            :sender => current_user, :is_conversation => true).order("created_at DESC")
    end

    def new_reply
        @message = Message.new
    end

    def send_reply
        @message = Message.new new_message_params
        if @message.valid?
            @message.conversation_id = params[:id]
            @message.sender = current_user
            conversation = Message.find params[:id]
            if conversation.sender == current_user
                @message.recipient = conversation.recipient
            else
                @message.recipient = conversation.sender
            end
            conversation.unread_by_recipient = true
            conversation.unread_by_sender = true
            conversation.save
            @message.is_conversation = false
            @message.save
            redirect_to message_show_path(conversation)
        else
            render :new_reply
        end
    end

    def show
        @message = Message.find params[:id]
        @message.modify_unread current_user
        @message.save
        @conversations = Message.where conversation: @message
        @reply = Message.new
    end

    private

    def new_message_params
        params.require(:message).permit(:subject, :content)
    end
end
