class CreateLegs < ActiveRecord::Migration
  def self.up
    create_table :legs do |t|
      t.string :distance
      t.string :co2
      t.string :name
      t.string :start_checkin
      t.string :end_checkin

      t.timestamps
    end
  end

  def self.down
    drop_table :legs
  end
end
