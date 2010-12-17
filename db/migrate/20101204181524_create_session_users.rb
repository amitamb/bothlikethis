class CreateSessionUsers < ActiveRecord::Migration
  def self.up
    create_table :session_users do |t|
      
      t.references :topic
      t.references :user
      
      t.string :given_username, :null => false
      
      t.float :weight, :default => 1

      t.timestamps
    end
    
    add_index :session_users, :given_username
    add_index :session_users, :topic_id
    
  end

  def self.down
    drop_table :session_users
  end
end
