class CreateWeightPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_prices do |t|
      t.integer :initial_weight
      t.integer :final_weight
      t.integer :weight_rate
      t.references :modality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
