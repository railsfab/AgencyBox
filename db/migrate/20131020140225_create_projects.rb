class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :slug
      t.integer :created_by_id

      t.timestamps
    end
  end
end
