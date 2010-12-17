class CreateOpinions < ActiveRecord::Migration
  def self.up
    create_table :opinions do |t|
      t.references :session_user
      t.references :topic_attribute
      t.integer :like_int # making it integer with 1 for like -1 for dislike for easier querying
      t.integer :action_type

      t.timestamps
    end

    add_index :opinions, :session_user_id
    add_index :opinions, :topic_attribute_id
    add_index :opinions, :like_int
    add_index :opinions, :action_type

    # there can be only one opinion form a user for a attribute
    add_index :opinions, [:session_user_id, :topic_attribute_id], :unique => true

  end

  def self.down
    drop_table :opinions
  end
end
