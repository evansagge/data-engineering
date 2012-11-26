class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.integer :purchases_count, default: 0
      t.timestamps
    end
  end
end
