class WeightPricesController < ApplicationController
    
    def index
        @weight_prices = WeightPrice.where(modality_id: params[:modality_id])
    end
    
end