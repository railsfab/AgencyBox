class Project < ActiveRecord::Base
    belongs_to :created_by, class_name: :User, foreign_key: :created_by_id

    #validations
    validates :name, presence: true, length: { :minimum => 5 }
    validates :description, presence: true, length: { :minimum => 5 }
    validate :create_and_validate_slug
    validates :slug, :uniqueness => { 
        message: ": Project with this name already exists, 
        please choose another name" }

    def create_and_validate_slug
        self.slug = self.name.parameterize
    end
end
