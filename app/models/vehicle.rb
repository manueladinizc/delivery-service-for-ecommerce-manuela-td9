class Vehicle < ApplicationRecord
  belongs_to :modality
  enum car_status: { operation: 0, maintenance: 1, delivery: 2 }
  validates :registration_plate, :brand, :car_model, :model_year, :weight_capacity, :car_status, :modality_id, presence: true
  has_many :modality
end
