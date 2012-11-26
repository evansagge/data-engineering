class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.float :price, default: 0.0
      t.integer :purchases_count, default: 0
      t.references :merchant
      t.timestamps
    end
  end
end
