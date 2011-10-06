class MakeCheckinsBelongToLegs < ActiveRecord::Migration
  def self.up

    change_table :checkins do |t|
      t.references :leg
    end

    change_table :legs do |t|
      t.references :user
    end

  end

  def self.down

    change_table :checkins do |t|
      t.remove_references :leg
    end

    change_table :legs do |t|
      t.remove_references :user
    end

  end
end
