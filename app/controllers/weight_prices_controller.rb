class WeightPricesController < ApplicationController
    before_action :authenticate_any!
    def index
        @weight_prices = WeightPrice.where(modality_id: params[:modality_id])
        @weight_price = WeightPrice.find_by(modality_id: params[:modality_id])
    end
    
end