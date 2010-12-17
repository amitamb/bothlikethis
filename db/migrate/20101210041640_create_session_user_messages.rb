class CreateSessionUserMessages < ActiveRecord::Migration
  def self.up
    create_table :session_user_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :session_user_messages
  end
end
