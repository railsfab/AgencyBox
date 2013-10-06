class Expense < ActiveRecord::Base
    belongs_to :category, class_name: :ExpenseCategory, foreign_key: :category_id
    belongs_to :user

    validates :amount, presence: true
    validates :description, presence: true, length: { :minimum => 5 }

    def categories
        ExpenseCategory.pluck(:name, :id)
    end

    def status_display
        status = "Pending"
        if self.status
            status = "Approved"
        else
            if self.rejected
                status = "Rejected"
            end
        end
        status
    end
end
