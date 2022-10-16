class WorkOrdersController < ApplicationController    
    before_action :authenticate_any!, only: [:index, :show, :new, :pending]
    def index        
        @work_orders = WorkOrder.all
    end

    def show
        @work_order = WorkOrder.find(params[:id])
        
        if OpenWorkOrder.where(:id => @work_order.id).present?
            @open_work_order = OpenWorkOrder.find(@work_order.id)
            @modality = Modality.find(@open_work_order.modality_id)
        end

        if CloseWorkOrder.where(:id => @work_order.id).present?
            @close_work_order = CloseWorkOrder.find(@work_order.id)
            
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

    def search_field

    end

    def search         
        @delivery_code = params["query"]
        @work_order = WorkOrder.find_by(delivery_code: params["query"])  

        if @delivery_code.blank? 
            flash[:notice] = 'Não há resultado para essa busca'
        elsif @work_order.nil?
            flash[:notice] = 'Não há resultado para essa busca'
            render search_field_work_orders_path
        else
            if OpenWorkOrder.where(:id => @work_order.id).present?
                @open_work_order = OpenWorkOrder.find(@work_order.id)
                 @modality = Modality.find(@open_work_order.modality_id)
            end
            
            if CloseWorkOrder.where(:id => @work_order.id).present?
                @close_work_order = CloseWorkOrder.find(@work_order.id)
                @close_work_order.delivery_date
            end
        end               
    end

    def pending
        @work_orders = WorkOrder.where('work_order_status = :value', value: 0)
    end

end