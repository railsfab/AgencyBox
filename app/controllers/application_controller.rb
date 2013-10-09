class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  #authorize_resource For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter authorize_resource
  check_authorization
end
