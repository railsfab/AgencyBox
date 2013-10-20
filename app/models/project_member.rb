class ProjectMember < ActiveRecord::Base
    belongs_to :project
    belongs_to :member, class_name: :User, foreign_key: :member_id
end
