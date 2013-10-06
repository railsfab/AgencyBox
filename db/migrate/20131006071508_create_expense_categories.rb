class CreateExpenseCategories < ActiveRecord::Migration
  def change
    create_table :expense_categories do |t|
      t.string :name
      t.string :slug
      t.decimal :max_limit, :default => 0
      t.string :description

      t.timestamps
    end

    add_index :expense_categories, :slug, :unique => true
  end
end
