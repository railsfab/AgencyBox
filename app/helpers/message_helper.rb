module MessageHelper
    def unread_check(message, current_user)
        if message.is_unread?(current_user)
            "unread"
        end
    end
end
