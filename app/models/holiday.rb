class Holiday < ActiveRecord::Base
    validates :name, presence: true
    validates :on, presence: true
end
