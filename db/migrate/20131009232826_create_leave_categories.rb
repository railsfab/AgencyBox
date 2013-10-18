class CreateLeaveCategories < ActiveRecord::Migration
  def change
    create_table :leave_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
