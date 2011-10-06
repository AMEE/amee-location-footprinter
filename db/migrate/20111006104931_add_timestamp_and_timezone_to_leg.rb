class AddTimestampAndTimezoneToLeg < ActiveRecord::Migration
  def self.up
    add_column :legs, :timestamp, :datetime
    add_column :legs, :timezone, :string
  end

  def self.down
    remove_column :legs, :timezone
    remove_column :legs, :timestamp
  end
end
