class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    #authorize_resource For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    #before_filter authorize_resource
    #check_authorization

    #before_filter :authorize_admin

    def not_found
        raise ActionController::RoutingError.new('Not Found')
    end

    protected

    #def authorize_admin
        #'''
        #Used if we want to authorize admin based on url
        #'''
        #if request.fullpath.index("/admin") == 0
            #if not current_user.has_role? :admin
                #not_found
            #end
        #end
    #end

    #def define_crumbs
        #'''
        #Not used now, but used when exact crumbs are required.
        #Currently using simple crumbs.
        #'''
        #@crumbs = [[ "Home", root_path() ]]
    #end
end
