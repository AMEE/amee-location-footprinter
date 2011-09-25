class AddFoursquareIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :foursquare_id, :string
  end

  def self.down
    remove_column :users, :foursquare_id
  end
end
