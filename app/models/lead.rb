class Lead < ActiveRecord::Base
    validates: :email, presence: true
    validates: :source, presence: true
    
    belongs_to :source, class_name: :LeadSource, foreignkey: :source_id

    
end
