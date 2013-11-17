class UsersController < ApplicationController
    before_filter :authenticate_user!

    def show
        @user = User.find params[:id]
    end
    
    def index
        @users = User.all
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        @user.assign_attributes modify_user_params
        if @user.valid?
            @user.save
            redirect_to user_path(@user)
        else
            render :edit
        end
        
    end

    private

    def modify_user_params
        params.require(:user).permit(:first_name, :last_name, :avatar)
    end
end
