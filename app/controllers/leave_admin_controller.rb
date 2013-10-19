class LeaveAdminController < ApplicationController
    def index
        @leaves = LeaveApplication.all
    end
end
