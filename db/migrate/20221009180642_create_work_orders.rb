class CreateWorkOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :work_orders do |t|
      t.string :pickup_address
      t.string :pickup_city
      t.string :pickup_state
      t.string :product_code
      t.integer :height
      t.integer :width
      t.integer :depth
      t.integer :weight
      t.string :delivery_address
      t.string :customer_name
      t.string :delivery_city
      t.string :delivery_state
      t.integer :distance
      t.integer :work_order_status, default: 0
      t.string :delivery_code

      t.timestamps
    end
  end
end
