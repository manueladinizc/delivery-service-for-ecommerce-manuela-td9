class DeadlinesController < ApplicationController
    before_action :authenticate_any!
    def index
        @deadlines = Deadline.where(modality_id: params[:modality_id]).order(:initial_distance)
        if Deadline.where(modality_id: params[:modality_id]).present?
            @deadline = @deadlines.first.modality_id
        end
        @modality = Modality.find(params[:modality_id])
        @deadline_id = Deadline.new
    end

    def create
        @modality = Modality.find(params[:modality_id])
        @deadline_id = @modality.deadlines.create(deadline_params)
        if @deadline_id.save()
            redirect_to modality_deadlines_path(@modality), notice: 'Intervalo de ditância cadastrado com sucesso.'
        else
            @deadlines = Deadline.where(modality_id: params[:modality_id]).order(:initial_distance)
            if Deadline.where(modality_id: params[:modality_id]).present?
                @deadline = @deadlines.first.modality_id
            end
            flash.now[:notice] = 'Intervalo de distância não cadastrado.'
            render 'index' 
        end
    end

    def edit
        @modality = Modality.find(params[:modality_id])
        @deadline_id = Deadline.find(params[:id])
    end

    def update
        @modality = Modality.find(params[:modality_id])
        @deadline_id = @modality.deadlines.find(params[:id])
        if @deadline_id.update(deadline_params)
            
            redirect_to modality_deadlines_path(@modality), notice: 'Configuração de prazo por distância atualizado com sucesso'
        else
            flash.now[:notice] = 'Não foi possível atualizar configuração de prazo por distância'
            render 'edit'
        end
    end

    private

    def deadline_params
        params.require(:deadline).permit(:initial_interval, :final_interval, :duration) 
    end
    
end

