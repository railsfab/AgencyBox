class LeaveApplication < ActiveRecord::Base
    belongs_to :user
    belongs_to :category, user_class: :LeaveCategory, foreign_key: :category_id

    validates :category, presence: true
    validates :reason, presence: true, length: { minimum: 5 }
    validates :from, presence: true
    validates :to, presence: true


end
