class ModalitiesController < ApplicationController

    before_action :set_modality, only: [:edit, :update]

    def new
        @modality = Modality.new
    end

    def create
        @modality = Modality.new(modality_params)
        if @modality.save()
            redirect_to root_path, notice: 'Modalidade cadastrado com sucesso.'
        else
            flash.now[:notice] = 'Modalidade não cadastrado.'
            render 'new'
        end 
    end

    def edit
    end

    def update
        
        if @modality.update(modality_params)
            redirect_to root_path, notice: 'Modalidade atualizado com sucesso'
            else
                flash.now[:notice] = 'Não foi possível atualizar Modalidade'
                render 'edit'
            end
    end

    private
    def set_modality 
        @modality = Modality.find(params[:id])
    end    

    def modality_params
        params.require(:modality).permit(:name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate, :modality_status) 
    end
end