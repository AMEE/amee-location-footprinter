class AddVenueNameToCheckin < ActiveRecord::Migration
  def self.up
    add_column :checkins, :venue_name, :string
  end

  def self.down
    remove_column :checkins, :venue_name
  end
end
