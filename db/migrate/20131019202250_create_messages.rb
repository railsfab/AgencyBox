class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.text :content
      t.string :subject
      t.boolean :is_conversation
      t.boolean :has_conversations, default: false
      t.boolean :unread, default: true
      t.integer :conversation_id

      t.timestamps
    end
  end
end
