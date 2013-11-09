class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, :null => false
      t.integer :source_id
      t.integer :converted_on
      t.boolean :is_client, default: false
      t.integer :account_id

      t.timestamps
    end
  end
end