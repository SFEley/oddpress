class CreateEnclosures < ActiveRecord::Migration
  def self.up
    create_table :enclosures do |t|
      t.integer :episode_id
      t.string :filename
      t.integer :size
      t.integer :duration

      t.timestamps
    end
  end

  def self.down
    drop_table :enclosures
  end
end
