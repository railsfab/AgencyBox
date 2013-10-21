class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.text :description
      t.integer :project_id
      t.integer :reported_by_id
      t.integer :assigned_to_id
      t.string :status
      

      t.timestamps
    end
  end
end
