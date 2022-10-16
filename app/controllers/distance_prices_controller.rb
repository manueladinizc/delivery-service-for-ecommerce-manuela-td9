class DistancePricesController < ApplicationController
    before_action :authenticate_any!
    def index
        @distance_prices = DistancePrice.where(modality_id: params[:modality_id])
        if DistancePrice.where(modality_id: params[:modality_id]).present?
            @distance_price = @distance_prices.first.modality_id        
        end
    end
    
end