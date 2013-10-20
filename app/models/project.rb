class Project < ActiveRecord::Base
    belongs_to :created_by, class_name: :User, foreign_key: :created_by_id

    has_many :project_members
    has_many :members, class_name: :User, through: :project_members, uniq: true

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

    def add_members(users)
        for user_id in users
            if ProjectMember.find_by(member_id: user_id, project: self).nil?
                self.members.append User.find(user_id)
            end
        end
    end


end
