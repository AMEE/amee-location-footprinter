class AddStartAndEndCheckinsToLeg < ActiveRecord::Migration
  def self.up
    rename_column :legs, :start_checkin, :start_checkin_id
    rename_column :legs, :end_checkin, :end_checkin_id
  end

  def self.down         
    rename_column :legs, :end_checkin_id, :end_checkin
    rename_column :legs, :start_checkin_id, :start_checkin
  end
end