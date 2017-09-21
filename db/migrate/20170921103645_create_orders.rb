class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.float :gross_amount
      t.float :tax_amount
      t.float :discount_amount
      t.float :net_amount

      t.timestamps null: false
    end
  end
end
