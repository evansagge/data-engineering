class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :quantity, default: 0
      t.float :total_price, default: 0.0
      t.references :purchaser
      t.references :merchant
      t.references :item
      t.references :record
      t.timestamps
    end
  end
end
