class WeightPricesController < ApplicationController
    before_action :authenticate_any!
    def index
        @weight_prices = WeightPrice.where(modality_id: params[:modality_id])
        if WeightPrice.where(modality_id: params[:modality_id]).present?
            @weight_price = @weight_prices.first.modality_id
        end
    end

    def edit
        @modality = Modality.find(params[:modality_id])
        #@modality = WeightPrice.find(params[:modality_id])
        @weight_price = WeightPrice.find(params[:id])
        
    end

    def update
        @modality = WeightPrice.find(params[:modality_id])
        @weight_price = WeightPrice.find(params[:id])
        if @weight_price.update(weight_price_params)
            
            redirect_to modality_weight_prices_path(@modality), notice: 'Configuração de preço por peso atualizado com sucesso'
            else
                flash.now[:notice] = 'Não foi possível atualizar configuração de preço por peso'
                render 'edit'
            end
    end
    
end

private

def weight_price_params
    params.require(:weight_price).permit(:initial_weight, :final_weight, :weight_rate) 
end