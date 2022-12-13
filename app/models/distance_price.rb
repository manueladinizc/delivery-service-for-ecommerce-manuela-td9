class DistancePrice < ApplicationRecord
  belongs_to :modality

  validates :initial_distance, :final_distance, :distance_rate, presence: true
  validate :create_interval, on: :create
  validate :update_interval, on: :update
  validate :table_interval
  validates :initial_distance, :final_distance, :distance_rate, numericality: { greater_than_or_equal_to: 0 }
  validates :initial_distance, comparison: { less_than: :final_distance }
  validates :final_distance, comparison: { greater_than: :initial_distance }

  def create_interval
    distance_prices = DistancePrice.where(modality_id: self.modality_id)
    distance_prices.each do |w|
      if (self.initial_distance.present? && self.initial_distance >= w.initial_distance && self.initial_distance <= w.final_distance)
        self.errors.add(:initial_distance, "já está contido em um intervalo")
      end
      if (self.final_distance.present? && self.final_distance >= w.initial_distance && self.final_distance <= w.final_distance)
        self.errors.add(:final_distance, "já está contido em um intervalo")
      end
    end
  end

  def update_interval
    distance_prices_all = DistancePrice.where(modality_id: self.modality_id)
    distance_prices_without_self =  DistancePrice.where('modality_id = :modality AND id != :id', modality: self.modality_id, id: self.id)
    distance_price_self =  DistancePrice.where('modality_id = :modality AND id = :id', modality: self.modality_id, id: self.id)

    if initial_distance_changed?
      if (self.initial_distance.present? && self.initial_distance > distance_price_self[0]['initial_distance'] && self.initial_distance < distance_price_self[0]['final_distance'])
      else
        distance_prices_all.each do |w|
          if (self.initial_distance.present? && self.initial_distance >= w.initial_distance && self.initial_distance <= w.final_distance)
            self.errors.add(:initial_distance, "já está contido em um intervalo")
          end
        end
      end
    end
   
    if final_distance_changed?
      if (self.final_distance.present? && self.final_distance <distance_price_self[0]['final_distance'] && self.final_distance >  distance_price_self[0]['initial_distance'])
      else
        distance_prices_all.each do |w|
          if (self.final_distance.present? && self.final_distance >= w.initial_distance && self.final_distance <= w.final_distance)
            self.errors.add(:final_distance, "já está contido em um intervalo")
          end
        end
      end
    end

  end
  

def table_interval 
  modality = Modality.where(id: self.modality_id)
  if self.initial_distance < self.modality.minimum_distance
    self.errors.add(:initial_distance, "está fora do limite estabelecido pela modalidade de entrega")
  end
  if self.final_distance > self.modality.maximum_distance
    self.errors.add(:final_distance, "está fora do limite estabelecido pela modalidade de entrega")
  end
end

end
