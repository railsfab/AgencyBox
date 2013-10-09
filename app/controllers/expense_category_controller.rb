class ExpenseCategoryController < ApplicationController
    before_filter :authenticate_user!

    def index
        @all = ExpenseCategory.all
    end

    def new
        @category = ExpenseCategory.new
    end

    def create
        @category = ExpenseCategory.new create_category_params
        if @category.valid?
            @category.save
            redirect_to :expense_category_index
        else
            render :new
        end
    end

    def edit
        @category = ExpenseCategory.find params[:id]
    end

    def modify
        @category = ExpenseCategory.find params[:id]
        @category.assign_attributes create_category_params
        
        if @category.valid?
            @category.save
            redirect_to expense_category_show_path(slug: @category.slug)
        else
            render :edit
        end
    end

    def show
        @category = ExpenseCategory.find_by slug: params[:slug]
    end

    private

    def create_category_params
        params.require(:expense_category).permit(:name, :description)
    end

end
