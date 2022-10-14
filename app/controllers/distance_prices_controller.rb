class DistancePricesController < ApplicationController
    before_action :authenticate_any!
    def index
        @distance_prices = DistancePrice.where(modality_id: params[:modality_id])
    end
    
end