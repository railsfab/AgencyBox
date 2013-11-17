class Leave::CategoriesController < ApplicationController
    before_filter :authenticate_user!


    def new
        @category = LeaveCategory.new
    end

    def create
        @category = LeaveCategory.new new_category_params
        if @category.valid?
            @category.save
            redirect_to :leave_categories
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

    def update 
        @category = LeaveCategory.find params[:id]
        @category.assign_attributes new_category_params
        
        if @category.valid?
            @category.save
            redirect_to leave_category_path(@category)
        else
            render :edit
        end
    end


    private

    def new_category_params
        params.require(:leave_category).permit(:name, :description)
    end
end
