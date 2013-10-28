class Message < ActiveRecord::Base
    belongs_to :sender, class_name: :User, foreign_key: :sender_id
    belongs_to :recipient, class_name: :User, foreign_key: :recipient_id
    belongs_to :conversation, class_name: Message, foreign_key: :conversation_id
    has_many :messages, class_name: Message, foreign_key: :conversation_id
    
    validates :subject, presence: true
    validates :content, presence: true

    before_save :update_has_conversations

    def update_has_conversations
        if not self.is_conversation
            conversation = self.conversation
            if conversation.recipient == self.sender
                if not conversation.has_conversations
                    conversation.has_conversations = true
                    conversation.save
                end
            end
        end
    end

    #def unread_count
        #unread = self.messages.where(unread: true).count
        #if self.unread
            #unread += 1
        #end
        #unread
    #end

    def short_subject
        subject = self.subject
        if subject.length > 50
            self.subject.slice(0, 50) + " ..."
        else
            self.subject
        end
    end

    def is_unread?(current_user)
        if self.recipient == current_user
            self.unread_by_recipient
        elsif self.sender == current_user
            self.unread_by_sender
        end
    end

    def modify_unread(current_user)
        if self.recipient == current_user
            self.unread_by_recipient = false
        elsif self.sender == current_user
            self.unread_by_sender = false
        end
    end
end
