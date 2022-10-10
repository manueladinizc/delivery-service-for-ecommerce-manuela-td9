class DistancePricesController < ApplicationController
    
    def index
        @distance_prices = DistancePrice.where(modality_id: params[:modality_id])
    end
    
end