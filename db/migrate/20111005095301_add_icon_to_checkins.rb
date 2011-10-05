class AddIconToCheckins < ActiveRecord::Migration
  def self.up
    add_column :checkins, :icon, :string
  end

  def self.down
    remove_column :checkins, :icon
  end
end
