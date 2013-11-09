class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :label
      t.string :content
      t.integer :lead_id

      t.timestamps
    end
  end
end
