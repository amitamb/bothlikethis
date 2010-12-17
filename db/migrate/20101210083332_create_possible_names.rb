class CreatePossibleNames < ActiveRecord::Migration
  def self.up
    create_table :possible_names do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :possible_names
  end
end
