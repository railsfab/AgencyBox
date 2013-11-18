module ApplicationHelper
    def silent_url_for(options = nil)
        options[:controller] = "/#{options[:controller]}"
        begin
            url_for(options)
        rescue Exception
            ''
        end
    end

end
