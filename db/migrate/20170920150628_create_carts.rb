class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :quantity
      t.float :total

      t.timestamps null: false
    end
  end
end
