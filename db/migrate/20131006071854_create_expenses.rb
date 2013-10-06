class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.integer :category_id
      t.decimal :amount
      t.boolean :status
      t.boolean :rejected
      t.string :description

      t.timestamps
    end
  end
end
