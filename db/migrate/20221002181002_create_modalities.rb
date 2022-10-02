class CreateModalities < ActiveRecord::Migration[7.0]
  def change
    create_table :modalities do |t|
      t.string :name
      t.integer :minimum_distance
      t.integer :maximum_distance
      t.integer :minimum_weight
      t.integer :maximum_weight
      t.integer :flat_rate
      t.integer :modality_status, :integer, default:0

      t.timestamps
    end
  end
end
