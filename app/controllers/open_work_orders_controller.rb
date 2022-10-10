class OpenWorkOrdersController < ApplicationController
    def new
        @work_order = WorkOrder.find(params[:work_order_id])
        @open_work_order = OpenWorkOrder.new()
        @modalities = Modality.all
        @deadlines = Deadline.all
        @weight_prices = WeightPrice.all
        @distance_prices = DistancePrice.all
        
    end
    def create
        @work_order = WorkOrder.find(params[:work_order_id])
        open_work_order_params = params.require(:open_work_order).permit(:modality_id, :deadline_id, :weight_prices_id, :distance_prices_id, :total_price)

        @open_work_order = OpenWorkOrder.new(open_work_order_params)
        @open_work_order.work_order = @work_order
        @open_work_order.save

        redirect_to @work_order, notice: 'Ordem iniciada com sucesso'
    end
end