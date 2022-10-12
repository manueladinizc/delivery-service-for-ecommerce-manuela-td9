class Modality < ApplicationRecord
    enum modality_status: { activated: 0, disabled: 1 }
    
    validates :name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate, :modality_status, presence: true   
    validates :name, uniqueness: true
    
    has_many :vehicles
    has_many :weight_prices
    has_many :distance_prices
    has_many :deadlines
    has_many :open_work_orders
    
end


