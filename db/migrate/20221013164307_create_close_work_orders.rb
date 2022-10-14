class CreateCloseWorkOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :close_work_orders do |t|
      t.references :work_order, null: false, foreign_key: true
      t.date :delivery_date
      t.string :description

      t.timestamps
    end
  end
end
