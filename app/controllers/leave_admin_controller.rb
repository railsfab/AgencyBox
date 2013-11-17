class LeaveAdminController < ApplicationController
    before_filter :authenticate_user!
    
    def edit
        @leave = LeaveApplication.find params[:id]
    end

    def modify
        leave = LeaveApplication.find params[:id]
        leave_status = params[:leave_status]
        if leave_status == "Approved"
            leave.status = true
            leave.rejected = false
        elsif leave_status == "Pending"
            leave.status = false
            leave.rejected = false
        elsif leave_status == "Rejected"
            leave.status = false
            leave.rejected = true
        end
        leave.save
        redirect_to leave_path(leave)
    end
end
