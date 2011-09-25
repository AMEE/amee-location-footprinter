class AddUserIdToCheckin < ActiveRecord::Migration
  def self.up
    add_column :checkins, :user_id, :integer
  end

  def self.down
    remove_column :checkins, :user_id
  end
end
