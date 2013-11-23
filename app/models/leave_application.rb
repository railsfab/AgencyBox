class LeaveApplication < ActiveRecord::Base
    belongs_to :user
    belongs_to :category, class_name: :LeaveCategory, foreign_key: :category_id

    validates :category, presence: true
    validates :reason, presence: true, length: { minimum: 5 }
    validates :start_date, presence: true
    validates :end_date, presence: true

    validate :update_num_of_days

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

    def update_num_of_days
        weekend_holidays = ENV['AGENCYBOX_WEEKEND_HOLIDAYS'].split("-").map(&:to_i)
        leaves = (self.start_date..self.end_date).select { |date| !weekend_holidays.include? date.wday }
        holidays_in_leaves = Holiday.where({'_on' => leaves}).pluck(:_on)
        num_of_days = (leaves-holidays_in_leaves).count
        self.num_of_days = num_of_days
        if num_of_days == 0
            errors[:base] << "You didnt select any working day."
        end
    end
end
