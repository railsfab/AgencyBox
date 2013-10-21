class Ticket < ActiveRecord::Base
    belongs_to :project, foreign_key: :project_id
    belongs_to :reported_by, class_name: "User", foreign_key: :reported_by_id
    belongs_to :assigned_to, class_name: "User", foreign_key: :assigned_to_id

    has_many :ticket_comments

    STATUS_OPTIONS = [['New', 'New'], ['Accepted', 'Accepted'],
        ['Test', 'Test'], ['Invalid', 'Invalid'], ['Fixed', 'Fixed']]

end
