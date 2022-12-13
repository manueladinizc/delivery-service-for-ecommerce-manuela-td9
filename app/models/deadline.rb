class Deadline < ApplicationRecord
  belongs_to :modality

  validates :initial_interval, :final_interval, :duration, presence: true
  validate :create_interval, on: :create
  validate :update_interval, on: :update
  validate :table_interval
  validates :initial_interval, :final_interval, :duration, numericality: { greater_than_or_equal_to: 0 }
  validates :initial_interval, comparison: { less_than: :final_interval }
  validates :final_interval, comparison: { greater_than: :initial_interval }

  def create_interval
    deadlines = Deadline.where(modality_id: self.modality_id)
    deadlines.each do |d|
      if (self.initial_interval.present? && self.initial_interval >= d.initial_interval && self.initial_interval <= d.final_interval)
        self.errors.add(:initial_interval, "já está contido em um intervalo")
      end
      if (self.final_interval.present? && self.final_interval >= d.initial_interval && self.final_interval <= d.final_interval)
        self.errors.add(:final_interval, "já está contido em um intervalo")
      end
    end
  end

  def update_interval
    deadlines_all = Deadline.where(modality_id: self.modality_id)
    deadlines_without_self =  Deadline.where('modality_id = :modality AND id != :id', modality: self.modality_id, id: self.id)
    deadline_self =  Deadline.where('modality_id = :modality AND id = :id', modality: self.modality_id, id: self.id)

    if initial_interval_changed?
      if (self.initial_interval.present? && self.initial_interval > deadline_self[0]['initial_interval'] && self.initial_interval < deadline_self[0]['final_interval'])
      else
        deadlines_all.each do |d|
          if (self.initial_interval.present? && self.initial_interval >= d.initial_interval && self.initial_interval <= d.final_interval)
            self.errors.add(:initial_interval, "já está contido em um intervalo")
          end
        end
      end
    end
   
    if final_interval_changed?
      if (self.final_interval.present? && self.final_interval <deadline_self[0]['final_interval'] && self.final_interval >  deadline_self[0]['initial_interval'])
      else
        deadlines_all.each do |d|
          if (self.final_interval.present? && self.final_interval >= d.initial_interval && self.final_interval <= d.final_interval)
            self.errors.add(:final_interval, "já está contido em um intervalo")
          end
        end
      end
    end

  end
  

def table_interval 
  modality = Modality.where(id: self.modality_id)
  if self.initial_interval < self.modality.minimum_distance
    self.errors.add(:initial_interval, "está fora do limite estabelecido pela modalidade de entrega")
  end
  if self.final_interval > self.modality.maximum_distance
    self.errors.add(:final_interval, "está fora do limite estabelecido pela modalidade de entrega")
  end
end

end
