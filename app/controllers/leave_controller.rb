class LeaveController < ApplicationController
    before_filter :authenticate_user!

    def new
        @leave = LeaveApplication.new
    end

    def create
        @leave = LeaveApplication.new new_leave_params
        if @leave.valid?
            @leave.user = current_user
            @leave.save
            redirect_to :leave_index
        else
            render :new
        end
    end

    def index
        if current_user.has_role? :admin
            @leaves = LeaveApplication.all
        else
            @leaves = LeaveApplication.where user: current_user
        end
    end

    def show
        @leave = LeaveApplication.find params[:id]
    end


    private

    def new_leave_params
        params.require(:leave_application).permit(:from, :to, :reason, :category_id)
    end
end
