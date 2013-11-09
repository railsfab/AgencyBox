class Lead < ActiveRecord::Base
    belongs_to :source, class_name: :LeadSource, foreign_key: :source_id

    validates :email, presence: true
    validates :source_id, presence: true
    validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
    validates :estimated_value, numericality: { only_integer: true }

    STAGES = [['Aware but not interested', 1],
              ['Interested', 2],
              ["Verbal commitment to buy", 3],
              ["Purchased", 4]]

    def sources
        LeadSource.pluck(:name, :id)
    end
    


    
end
