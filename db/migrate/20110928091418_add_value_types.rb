class AddValueTypes < ActiveRecord::Migration
  def self.up
    add_column :terms, :value_type, :string
  end

  def self.down
    remove_column :terms, :value_type
  end
end