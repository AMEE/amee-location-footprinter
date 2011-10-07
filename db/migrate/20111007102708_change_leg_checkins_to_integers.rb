class ChangeLegCheckinsToIntegers < ActiveRecord::Migration
  def self.up
    remove_column :legs, :start_checkin
    add_column :legs, :start_checkin, :int
    
  end                  
                       
  def self.down        
    remove_column :legs, :start_checkin
    add_column :legs, :start_checkin, :string


  end
end