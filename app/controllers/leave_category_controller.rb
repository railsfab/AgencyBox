class LeaveCategoryController < ApplicationController

    def new
        @category = LeaveCategory.new
    end

    def create
        @category = LeaveCategory.new new_category_params
        if @category.valid?
            @category.save
            redirect_to :leave_category_index
        else
            render :new
        end
    end
    
    def index
        @categories = LeaveCategory.all
    end

    def show
        @category = LeaveCategory.find params[:id]
    end

    def edit
        @category = LeaveCategory.find params[:id]
    end

    def modify
        @category = LeaveCategory.find params[:id]
        @category.assign_attributes new_category_params
        
        if @category.valid?
            @category.save
            redirect_to leave_category_show_path(@category)
        else
            render :edit
        end
    end


    private

    def new_category_params
        params.require(:leave_category).permit(:name, :description)
    end
end
