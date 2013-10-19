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
        if params.include?("status")
            if params['status'] == "pending"
                @leaves = @leaves.where({ :status => false, :rejected => false })
            elsif params["status"] == "approved"
                @leaves = @leaves.where({ :status => true, :rejected => false })
            elsif params["status"] == "rejected"
                @leaves = @leaves.where({ :status => false, :rejected => true })
            end
        end

        if params.include?(:amount_filter)
            if params[:amount_filter] == "asc"
                @leaves = @leaves.order("start_date ASC")
            elsif params[:amount_filter] == "desc"
                @leaves = @leaves.order("start_date desc")
            end
        end

        if params.include?(:user)
            @leaves = @leaves.where(:user_id => params[:user])
        end

        @users = User.all
    end

    def show
        @leave = LeaveApplication.find params[:id]
    end


    private

    def new_leave_params
        params.require(:leave_application).permit(:start_date, :end_date, :reason, :category_id)
    end
end
