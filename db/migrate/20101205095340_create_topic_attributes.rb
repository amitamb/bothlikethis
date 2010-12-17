class CreateTopicAttributes < ActiveRecord::Migration
  def self.up
    create_table :topic_attributes do |t|
      t.string :text
      
      t.float :weight
      #add_column :topic_attributes, :weight, :float, :default => 0

      t.timestamps
    end

	add_index :topic_attributes, :text

  end

  def self.down
    drop_table :topic_attributes
  end
end
