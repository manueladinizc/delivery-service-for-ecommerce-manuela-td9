class Modality < ApplicationRecord
    enum modality_status: { activated: 0, disabled: 1 }
    
    validates :name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate, :modality_status, presence: true   
    validates :name, uniqueness: true
    
    has_many :vehicles
    
end
