class WeightPrice < ApplicationRecord
  belongs_to :modality

  validates :initial_weight, :final_weight, :weight_rate, presence: true
  validate :check_interval


  
  def check_interval
    weight_prices = WeightPrice.where(modality_id: self.modality_id)
    weight_prices.each do |w|
      if (self.initial_weight.present? && self.initial_weight >= w.initial_weight && self.initial_weight <= w.final_weight)
        self.errors.add(:initial_weight, "já está contido em um intervalo")
      end
      if (self.final_weight.present? && self.final_weight >= w.initial_weight && self.final_weight <= w.final_weight)
        self.errors.add(:final_weight, "já está contido em um intervalo")
      end
    end
  end

end
