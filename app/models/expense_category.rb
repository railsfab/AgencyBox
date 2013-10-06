class ExpenseCategory < ActiveRecord::Base
    validates :name, presence: true, length: { :minimum => 5, :maximum => 30 }
    validates :description, presence: true, length: { :minimum => 5 }
    validate :create_and_validate_slug
    validates :slug, :uniqueness => { message: ": Category already exists, please choose another category" }

    def create_and_validate_slug
        self.slug = self.name.parameterize
    end
end
