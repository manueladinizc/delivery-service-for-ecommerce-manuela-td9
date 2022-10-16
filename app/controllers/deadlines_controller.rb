class DeadlinesController < ApplicationController
    before_action :authenticate_any!
    def index
        @deadlines = Deadline.where(modality_id: params[:modality_id])
        if Deadline.where(modality_id: params[:modality_id]).present?
            @deadline = @deadlines.first.modality_id        
        end
    end
    
end

