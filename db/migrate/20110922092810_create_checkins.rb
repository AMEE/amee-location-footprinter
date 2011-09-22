class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.string :lat
      t.string :lon
      t.timestamp :timestamp
      t.string :foursquare_id
      t.string :timezone

      t.timestamps
    end
  end

  def self.down
    drop_table :checkins
  end
end
