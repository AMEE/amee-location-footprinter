class CreatePersistenceTables < ActiveRecord::Migration
  def self.up
    create_table :calculations do |t|
      t.string  "profile_uid"
      t.string  "profile_item_uid"
      t.string  "calculation_type"

      t.timestamps
    end

    create_table :terms do |t|
      t.integer  "calculation_id"
      t.string  "label"
      t.string  "value"

      t.timestamps
    end

    add_index :calculations, :calculation_type
    add_index :calculations, :profile_item_uid
    add_index :terms, [:calculation_id, :label], :name => "calc_id_label_index"
    add_index :terms, [:label, :value, :calculation_id], :name => "label_name_calc_id_index"
  end

  def self.down
    drop_table :calculations
    drop_table :terms
  end
end
