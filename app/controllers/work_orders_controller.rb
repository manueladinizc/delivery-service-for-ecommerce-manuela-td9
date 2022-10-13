class WorkOrdersController < ApplicationController
    def index
        
        @work_orders = WorkOrder.all
    end

    def show
        @work_order = WorkOrder.find(params[:id])
        
        if OpenWorkOrder.where(:id => @work_order.id).present?
            @open_work_order = OpenWorkOrder.find(@work_order.id)
            @modality = Modality.find(@open_work_order.modality_id)
        end


    end

    def new
        @work_order = WorkOrder.new
    end

    def create
        @work_order = WorkOrder.new(params.require(:work_order).permit(:pickup_address, :pickup_city, :pickup_state, :product_code, :height, :width, :depth, :weight, :delivery_address, :customer_name , :delivery_city, :delivery_state, :distance))

        if @work_order.save
            redirect_to work_orders_path, notice: 'Ordem de serviço cadastrada com sucesso'
        else
            flash.now[:alert] = 'Ordem de serviço não cadastrado.'
            render 'new'
        end
    end
end