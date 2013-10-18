class CreateLeaveProfiles < ActiveRecord::Migration
  def change
    create_table :leave_profiles do |t|
      t.integer :user_id
      t.integer :used_leaves

      t.timestamps
    end
  end
end
