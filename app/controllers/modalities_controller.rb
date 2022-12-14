class ModalitiesController < ApplicationController
     before_action :authenticate_any!   

    def show
        @modality = Modality.find(params[:id])
    end
   

    def index
        @modalities = Modality.all
        
    end

    def new
        @modality = Modality.new
    end

    def create
        @modality = Modality.new(modality_params)
        if @modality.save()

            redirect_to modalities_path, notice: 'Modalidade cadastrado com sucesso.'
        else
            flash.now[:notice] = 'Modalidade não cadastrada.'
            render 'new'
        end 
    end

    def edit
        @modality = Modality.find(params[:id])
    end
    
    def update
        @modality = Modality.find(params[:id])
        if @modality.update(modality_params)
            
            redirect_to modalities_path, notice: 'Modalidade atualizado com sucesso'
            else
                flash.now[:notice] = 'Não foi possível atualizar Modalidade'
                render 'edit'
            end
    end

    private
    def modality_params
        params.require(:modality).permit(:name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate, :modality_status) 
    end
end