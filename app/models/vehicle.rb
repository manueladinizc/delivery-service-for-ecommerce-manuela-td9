class Vehicle < ApplicationRecord
  belongs_to :modality

  enum car_status: { operation: 0, maintenance: 1, delivery: 2 }

  validates :registration_plate, :brand, :car_model, :model_year, :weight_capacity, :car_status, :modality_id, presence: true
  validates :registration_plate, format: {with: /\A[A-Z0-9]{6}\z/, message: "deve conter 6 caracteres, com números ou letras maiúsculas"}
  validates :registration_plate, uniqueness:true
  validates :model_year, format: {with: /\A[0-9]{4}\z/, message: "deve conter 4 números"}
  
  validate :min_weight

  def min_weight
    if (self.weight_capacity.present? && self.weight_capacity <= 0)
      self.errors.add(:weight_capacity, "deve ser maior que 0")
       end
  end
end
