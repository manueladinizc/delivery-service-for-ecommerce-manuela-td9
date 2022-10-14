class OpenWorkOrdersController < ApplicationController
    
    def new        
       
        data_processing

        @name_column = ['Modalidade', 'Prazo (dias)', 'Preço (R$)' ]
        @rows_val = [@name_modality, @time_deadline, @total_price_values ]
               
    end


    def create
        data_processing

        @work_order = WorkOrder.find(params[:work_order_id])        
        open_work_order_params = params.require(:open_work_order).permit(:modality_id,  :total_price, :deadline_date)

        @open_work_order = OpenWorkOrder.new(open_work_order_params)
       

        position = @modality_n_id.index(@open_work_order.modality_id)
        @open_work_order.total_price = @total_price_values[position]
        @open_work_order.deadline_date = (@time_deadline[position]).days.from_now
                
        @open_work_order.work_order = @work_order
           
      if @open_work_order.save!
         @work_order.progress!
        redirect_to @work_order, notice: 'Ordem iniciada com sucesso'
      else 
        @open_work_order = OpenWorkOrder.all
        flash.now[:notice] = "Não foi possivel iniciar ordem"
        redirect_to @work_order
      end
    end

    def show
       
    end
    
    def data_processing
        @work_order = WorkOrder.find(params[:work_order_id])        
        @open_work_order = OpenWorkOrder.new()

        @modalities = Modality.all
        @deadlines = Deadline.all
        @weight_prices = WeightPrice.all
        @distance_prices = DistancePrice.all
        @weight_value = WeightPrice.where('initial_weight <= :value AND final_weight >= :value', value: @work_order.weight)
        
        @distance_value = DistancePrice.where('initial_distance <= :value AND final_distance >= :value', value: @work_order.distance)
      
        @deadline_value = Deadline.where('initial_interval <= :value AND final_interval >= :value', value: @work_order.distance)
       
        @tax_weight = []
        @weight_value.each do |w|
            @tax_weight << w.weight_rate
        end
           
        @tax_distance = []
        @distance_value.each do |d|
            @tax_distance << d.distance_rate
        end

        @time_deadline = []
        @deadline_value.each do |d|
            @time_deadline << d.duration
        end
        
        @id_modality = []
        @weight_value.each do |id|
            @id_modality << id.modality_id
        end
        
        j=0
        @tax_modality = []
        @name_modality = []
        @modality_n_id = []
        @modality_group = []
        while j < @id_modality.length do
            @tax_modality << Modality.find(@id_modality[j]).flat_rate
            @name_modality << Modality.find(@id_modality[j]).name
            @modality_n_id << Modality.find(@id_modality[j]).id
            @modality_group << Modality.find(@id_modality[j])
            j+=1
        end
        
        i=0
        @total_price_values=[]
        while i < @tax_weight.length do
            @total_price_values[i] = (@work_order.weight * @tax_weight[i]) + @tax_distance[i]  + @tax_modality[i]
            i+=1
        end

    end
    


end