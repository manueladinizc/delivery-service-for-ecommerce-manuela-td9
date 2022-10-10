class CreateOpenWorkOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :open_work_orders do |t|
      t.references :modality, null: false, foreign_key: true
      t.references :deadline, null: false, foreign_key: true
      t.references :distance_price, null: false, foreign_key: true
      t.references :weight_price, null: false, foreign_key: true
      t.references :work_order, null: false, foreign_key: true
      t.integer :total_price

      t.timestamps
    end
  end
end
