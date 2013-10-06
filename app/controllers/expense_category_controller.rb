class ExpenseCategoryController < ApplicationController
    before_filter :authenticate_user!

    def index
        @all = ExpenseCategory.all
    end

    def new
        @category = ExpenseCategory.new
    end

    def create
        @category = ExpenseCategory.new new_category_params
        if @category.valid?
            @category.save
            redirect_to :expense_category_index
        else
            render :new
        end
    end

    def show
        @category = ExpenseCategory.find_by slug: params[:slug]
    end

    private

    def new_category_params
        params.require(:expense_category).permit(:name, :description)
    end

end
