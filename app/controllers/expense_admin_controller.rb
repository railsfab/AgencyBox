class ExpenseAdminController < ApplicationController
    before_filter :authenticate_user!

    def edit
        @expense = Expense.find params[:id]
    end

    def modify
        expense = Expense.find params[:id]
        expense_status = params[:expense_status]
        if expense_status == "Approved"
            expense.status = true
            expense.rejected = false
        elsif expense_status == "Pending"
            expense.status = false
            expense.rejected = false
        elsif expense_status == "Rejected"
            expense.status = false
            expense.rejected = true
        end
        expense.save
        redirect_to expense_show_path(expense)
    end
end
