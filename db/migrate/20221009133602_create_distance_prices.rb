class CreateDistancePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :distance_prices do |t|
      t.integer :initial_distance
      t.integer :final_distance
      t.integer :distance_rate
      t.references :modality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
