class AddLastEmailSentToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_email_sent, :timestamp
  end

  def self.down
    remove_column :users, :last_email_sent
  end
end
