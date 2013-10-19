class Holiday < ActiveRecord::Base
    validates :name, presence: true
    validates :_on, presence: true
end
