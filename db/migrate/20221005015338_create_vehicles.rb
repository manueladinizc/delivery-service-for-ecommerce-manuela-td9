class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.integer :registration_plate
      t.string :brand
      t.string :car_model
      t.integer :model_year
      t.integer :weight_capacity
      t.integer :car_status, default:0
      t.references :modality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
