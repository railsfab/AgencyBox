class CreateExpenseCategories < ActiveRecord::Migration
  def change
    create_table :expense_categories do |t|
      t.string :name
      t.decimal :max_limit
      t.string :description

      t.timestamps
    end
  end
end
