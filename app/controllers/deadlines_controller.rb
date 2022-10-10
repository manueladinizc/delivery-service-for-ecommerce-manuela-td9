class DeadlinesController < ApplicationController
    
    def index
        @deadlines = Deadline.where(modality_id: params[:modality_id])
    end
    
end