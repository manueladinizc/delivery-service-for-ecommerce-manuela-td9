class DistancePricesController < ApplicationController
    before_action :authenticate_any!
    def index
        @distance_prices = DistancePrice.where(modality_id: params[:modality_id]).order(:initial_distance)
        if DistancePrice.where(modality_id: params[:modality_id]).present?
          @distance_price = @distance_prices.first.modality_id
        end
        @modality = Modality.find(params[:modality_id])
        @distance_price_id = DistancePrice.new
    end

    def create
      @modality = Modality.find(params[:modality_id])
      @distance_price_id = @modality.distance_prices.create(distance_price_params)
      if @distance_price_id.save()
          redirect_to modality_distance_prices_path(@modality), notice: 'Intervalo cadastrado com sucesso.'
      else
          @distance_prices = DistancePrice.where(modality_id: params[:modality_id]).order(:initial_distance)
          if DistancePrice.where(modality_id: params[:modality_id]).present?
              @distance_price = @distance_prices.first.modality_id
          end
          flash.now[:notice] = 'Intervalo não cadastrada.'
          render 'index' 
      end
  end

  def edit
    @modality = Modality.find(params[:modality_id])
    @distance_price_id = DistancePrice.find(params[:id])
end

def update
  @modality = Modality.find(params[:modality_id])
  @distance_price_id = @modality.distance_prices.find(params[:id])
  if @distance_price_id.update(distance_price_params)
      
      redirect_to modality_distance_prices_path(@modality), notice: 'Configuração de preço por distância atualizado com sucesso'
  else
      flash.now[:notice] = 'Não foi possível atualizar configuração de preço por distância'
      render 'edit'
  end
end

private

def distance_price_params
    params.require(:distance_price).permit(:initial_distance, :final_distance, :distance_rate) 
end

end