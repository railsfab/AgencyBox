class LeaveApplication < ActiveRecord::Base
    belongs_to :user
    belongs_to :category, class_name: :LeaveCategory, foreign_key: :category_id

    validates :category, presence: true
    validates :reason, presence: true, length: { minimum: 5 }
    validates :from, presence: true
    validates :to, presence: true

    def categories
        LeaveCategory.pluck(:name, :id)
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
