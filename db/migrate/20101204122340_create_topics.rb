class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :name, :null => false
      t.string :description
      t.string :image_url, :null => false
      t.string :image_attribution_text
      t.datetime :time_to_show, :null => false

      t.timestamps
    end
    
    add_index :topics, :name
    
  end

  def self.down
    drop_table :topics
  end
end
