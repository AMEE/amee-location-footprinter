class AddUnitColumns < ActiveRecord::Migration
  def self.up

    add_column :terms, :unit, :string
    add_column :terms, :per_unit, :string

  end

  def self.down

    remove_column :terms, :unit, :string
    remove_column :terms, :per_unit

  end
end