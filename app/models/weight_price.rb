class WeightPrice < ApplicationRecord
  belongs_to :modality

  validates :initial_weight, :final_weight, :weight_rate, presence: true 
end
