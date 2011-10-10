class ChangeLegCheckinsToIntegers < ActiveRecord::Migration
  def self.up
    remove_column :legs, :start_checkin
    remove_column :legs, :end_checkin
    add_column :legs, :start_checkin, :int
    add_column :legs, :end_checkin, :int    
  end                  
                       
  def self.down        
    remove_column :legs, :start_checkin
    remove_column :legs, :end_checkin
    add_column :legs, :start_checkin, :string
    add_column :legs, :end_checkin, :string

  end
end