class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.integer :category_id
      t.decimal :amount
      t.boolean :status,       default: false
      t.boolean :rejected,     default: false
      t.string :description

      t.timestamps
    end
  end
end
