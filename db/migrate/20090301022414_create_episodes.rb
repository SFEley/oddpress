class CreateEpisodes < ActiveRecord::Migration
  def self.up
    create_table :episodes do |t|
      t.string :title, :null => false
      t.text :description
      t.datetime :posted_at, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :episodes
  end
end
