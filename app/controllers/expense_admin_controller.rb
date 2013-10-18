class ExpenseAdminController < ApplicationController
    def index
        @expenses = Expense.all
        if params.include?("status")
            if params['status'] == "pending"
                @expenses = @expenses.where({ :status => false, :rejected => false })
            elsif params["status"] == "approved"
                @expenses = @expenses.where({ :status => true, :rejected => false })
            elsif params["status"] == "rejected"
                @expenses = @expenses.where({ :status => false, :rejected => true })
            end
        end

        if params.include?(:amount_filter)
            if params[:amount_filter] == "asc"
                @expenses = @expenses.order("amount ASC")
            elsif params[:amount_filter] == "desc"
                @expenses = @expenses.order("amount desc")
            end
        end
    end

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
