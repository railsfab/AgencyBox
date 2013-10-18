class CreateLeaveApplications < ActiveRecord::Migration
  def change
    create_table :leave_applications do |t|
      t.text :reason
      t.date :from
      t.date :to
      t.integer :num_of_days
      t.integer :user_id
      t.integer :category_id
      t.boolean :status
      t.boolean :rejected

      t.timestamps
    end
  end
end
