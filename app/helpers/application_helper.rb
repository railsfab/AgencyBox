module ApplicationHelper
    def silent_url_for(options = nil)
        begin
            url_for(options)
        rescue Exception
            ''
        end
    end

end
