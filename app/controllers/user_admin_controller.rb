class UserAdminController < ApplicationController
    before_filter :authenticate_user!

end
