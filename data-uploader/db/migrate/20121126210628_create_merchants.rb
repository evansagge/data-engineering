class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :address
      t.integer :purchases_count, default: 0
      t.integer :items_count, default: 0
      t.timestamps
    end
  end
end
