class CreateTicketComments < ActiveRecord::Migration
  def change
    create_table :ticket_comments do |t|
      t.text :content
      t.integer :ticket_id
      t.integer :created_by_id

      t.timestamps
    end
  end
end
