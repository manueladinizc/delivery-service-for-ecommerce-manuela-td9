class CloseWorkOrdersController < ApplicationController
    def new
        @work_order = WorkOrder.find(params[:work_order_id])        
        @close_work_order = CloseWorkOrder.new()
    end

    def create
        
        @work_order = WorkOrder.find(params[:work_order_id])
        @open_work_order = OpenWorkOrder.find(params[:work_order_id])
        
        close_work_order_params = params.require(:close_work_order).permit(:delivery_date, :description)
        
        @close_work_order = CloseWorkOrder.new(close_work_order_params)
        @close_work_order.work_order = @work_order
        
        if (@close_work_order.delivery_date <= @open_work_order.deadline_date)
            @close_work_order.save!
            @work_order.closed_in!
            redirect_to  work_orders_path

             
        elsif ((@close_work_order.description.blank?) && (@close_work_order.delivery_date > @open_work_order.deadline_date))
            
            flash.now[:notice] = 'Ordem não pode ser encerrada, digite o motivo.'
            render 'new'

        else 
            @close_work_order.save!
            @work_order.closed_out!
            redirect_to  work_orders_path
        end
    
    end


end