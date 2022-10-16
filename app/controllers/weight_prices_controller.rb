class WeightPricesController < ApplicationController
    before_action :authenticate_any!
    def index
        @weight_prices = WeightPrice.where(modality_id: params[:modality_id])
        if WeightPrice.where(modality_id: params[:modality_id]).present?
            @weight_price = @weight_prices.first.modality_id        
        end
    end
    
end