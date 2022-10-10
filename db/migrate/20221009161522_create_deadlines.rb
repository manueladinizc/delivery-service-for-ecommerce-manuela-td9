class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.integer :initial_interval
      t.integer :final_interval
      t.integer :duration
      t.references :modality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
