class OpenWorkOrder < ApplicationRecord
  belongs_to :modality
  belongs_to :deadline
  belongs_to :distance_price
  belongs_to :weight_price
  belongs_to :work_order
end
