class Lead < ActiveRecord::Base
    belongs_to :source, class_name: :LeadSource, foreign_key: :source_id

    validates :email, presence: true
    validates :source_id, presence: true
    validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

    def sources
        LeadSource.pluck(:name, :id)
    end
    


    
end
