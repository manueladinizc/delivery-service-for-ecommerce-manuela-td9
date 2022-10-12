class OpenWorkOrder < ApplicationRecord
  belongs_to :modality
  
  belongs_to :work_order
end
