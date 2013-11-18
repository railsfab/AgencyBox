class ExpensesController < ApplicationController
    #before_filter :authenticate_user!, :add_to_crumbs
    before_filter :authenticate_user!



    def index
        if current_user.has_role? :admin
            @expenses = Expense.all
        else
            @expenses = Expense.where user: current_user
        end
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

        if params.include?(:user)
            if current_user.has_role? :admin
                @expenses = @expenses.where(:user_id => params[:user])
            end
        end

        @users = User.all
    end

    def new
        @expense = Expense.new
    end

    def create
        @expense = Expense.new create_expense_params
        if @expense.valid?
            @expense.user = current_user
            @expense.save
            redirect_to :expenses
        else
            render :new
        end
    end

    def show
        @expense = Expense.find params[:id]
    end

    def edit
        @expense = Expense.find params[:id]
    end

    def update
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
        redirect_to expense_path(expense)
    end

    private

    #def add_to_crumbs
    #    '''
    #    Not used now, but can be used when exact crumbs are required.
    #    Currently using simply crumbs using javascript
    #    '''
    #    @crumbs.append ["Expenses", expense_index_path() ]
    #end

    def create_expense_params
        params.require(:expense).permit(:amount, :category_id, :description)
    end

end
