class CreateLeaveApplications < ActiveRecord::Migration
  def change
    create_table :leave_applications do |t|
      t.text :reason
      t.date :start_date
      t.date :end_date
      t.integer :num_of_days
      t.integer :user_id
      t.integer :category_id
      t.boolean :status,        default: false
      t.boolean :rejected,      default: false

      t.timestamps
    end
  end
end
