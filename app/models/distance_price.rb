class DistancePrice < ApplicationRecord
  belongs_to :modality
  has_many :open_work_order
end
