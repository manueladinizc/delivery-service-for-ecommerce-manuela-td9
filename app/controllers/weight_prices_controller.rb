class WeightPricesController < ApplicationController
    before_action :authenticate_any!
    def index
        @weight_prices = WeightPrice.where(modality_id: params[:modality_id]).order(:initial_weight)
        if WeightPrice.where(modality_id: params[:modality_id]).present?
            @weight_price = @weight_prices.first.modality_id
        end
        @modality = Modality.find(params[:modality_id])
        @weight_price_id = WeightPrice.new
    end
    
    def create
        @modality = Modality.find(params[:modality_id])
        @weight_price_id = @modality.weight_prices.create(weight_price_params)
        if @weight_price_id.save()
            redirect_to modality_weight_prices_path(@modality), notice: 'Intervalo cadastrado com sucesso.'
        else
            @weight_prices = WeightPrice.where(modality_id: params[:modality_id]).order(:initial_weight)
            if WeightPrice.where(modality_id: params[:modality_id]).present?
                @weight_price = @weight_prices.first.modality_id
            end
            flash.now[:notice] = 'Intervalo não cadastrada.'
            render 'index' 
        end  
    end


    def edit
        @modality = Modality.find(params[:modality_id])
        @weight_price_id = WeightPrice.find(params[:id])
    end

    def update
        @modality = Modality.find(params[:modality_id])
        @weight_price_id = @modality.weight_prices.find(params[:id])
        if @weight_price_id.update(weight_price_params)
            
            redirect_to modality_weight_prices_path(@modality), notice: 'Configuração de preço por peso atualizado com sucesso'
        else
            flash.now[:notice] = 'Não foi possível atualizar configuração de preço por peso'
            render 'edit'
        end
    end

private

def weight_price_params
    params.require(:weight_price).permit(:initial_weight, :final_weight, :weight_rate) 
end

end