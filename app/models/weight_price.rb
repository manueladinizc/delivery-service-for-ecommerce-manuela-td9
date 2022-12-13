class WeightPrice < ApplicationRecord
  belongs_to :modality

  validates :initial_weight, :final_weight, :weight_rate, presence: true
  validate :create_interval, on: :create
  validate :update_interval, on: :update
  validate :table_interval
  validates :initial_weight, :final_weight, :weight_rate, numericality: { greater_than_or_equal_to: 0 }
  validates :initial_weight, comparison: { less_than: :final_weight }
  validates :final_weight, comparison: { greater_than: :initial_weight }


  def create_interval
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

  def update_interval
    weight_prices_all = WeightPrice.where(modality_id: self.modality_id)
    weight_prices_without_self =  WeightPrice.where('modality_id = :modality AND id != :id', modality: self.modality_id, id: self.id)
    weight_price_self =  WeightPrice.where('modality_id = :modality AND id = :id', modality: self.modality_id, id: self.id)

    if initial_weight_changed?
      if (self.initial_weight.present? && self.initial_weight > weight_price_self[0]['initial_weight'] && self.initial_weight < weight_price_self[0]['final_weight'])
      else
        weight_prices_all.each do |w|
          if (self.initial_weight.present? && self.initial_weight >= w.initial_weight && self.initial_weight <= w.final_weight)
            self.errors.add(:initial_weight, "já está contido em um intervalo")
          end
        end
      end
    end
   
    if final_weight_changed?
      if (self.final_weight.present? && self.final_weight <weight_price_self[0]['final_weight'] && self.final_weight >  weight_price_self[0]['initial_weight'])
      else
        weight_prices_all.each do |w|
          if (self.final_weight.present? && self.final_weight >= w.initial_weight && self.final_weight <= w.final_weight)
            self.errors.add(:final_weight, "já está contido em um intervalo")
          end
        end
      end
    end

  end
  

def table_interval 
  modality = Modality.where(id: self.modality_id)
  if self.initial_weight < self.modality.minimum_weight
    self.errors.add(:initial_weight, "está fora do limite estabelecido pela modalidade de entrega")
  end
  if self.final_weight > self.modality.maximum_weight
    self.errors.add(:final_weight, "está fora do limite estabelecido pela modalidade de entrega")
  end
end

end

