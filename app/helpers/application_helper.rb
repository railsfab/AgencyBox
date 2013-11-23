module ApplicationHelper
    def silent_url_for(options = nil)
        options[:controller] = "/#{options[:controller]}"
        begin
            url_for(options)
        rescue Exception
            ''
        end
    end


    def gravatar_image(email)
        id = Digest::MD5.hexdigest(email)
        "http://gravatar.com/avatar/#{id}.png?s=70"
    end

end
