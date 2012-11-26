class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :user
      t.string :status, default: "pending"
      t.string :notes
      t.integer :purchases_count, default: 0
      t.timestamps
    end

    add_attachment :records, :raw_data
  end
end
