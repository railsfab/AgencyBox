class ExpenseController < ApplicationController
    before_filter :authenticate_user!

    def index
        @expenses = Expense.all
    end

    def new
        @expense = Expense.new
    end

    def create
        @expense = Expense.new create_expense_params
        if @expense.valid?
            @expense.user = current_user
            @expense.save
            redirect_to :expense_index
        else
            render :new
        end
    end

    def show
        @expense = Expense.find params[:id]
    end

    private

    def create_expense_params
        params.require(:expense).permit(:amount, :category_id, :description)
    end

end
