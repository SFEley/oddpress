class AddStatusToEpisode < ActiveRecord::Migration
  def self.up
    add_column :episodes, :status, :string
  end

  def self.down
    remove_column :episodes, :status
  end
end
