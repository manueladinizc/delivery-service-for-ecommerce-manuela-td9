class VehiclesController < ApplicationController
    before_action :set_vehicle, only: [:edit, :update]
    before_action :authenticate_any!
    def index 
        @vehicles = Vehicle.all
        
    end

    def new
        @vehicle = Vehicle.new
        @modalities = Modality.all
    end

    def create
        @vehicle = Vehicle.new(vehicle_params)

        if @vehicle.save
            redirect_to vehicles_path, notice: 'Veículo cadastrado com sucesso.'
        else
            
            #@modalities = Modality.all
            @vehicles = Vehicle.all
            flash.now[:notice] = 'Veículo não cadastrado.'
            render 'new'
        end 
    end

    def edit
    end
    
    def update
        
        if @vehicle.update(vehicle_params)
            
            redirect_to vehicles_path, notice: 'Veículo atualizado com sucesso'
            else
                flash.now[:notice] = 'Não foi possível atualizar veículo'
                render 'edit'
            end
    end

    def search       
        @registration_plate = params["query"]
        @vehicles = Vehicle.where("registration_plate LIKE ?", "%#{@registration_plate}%" )         
    end





    private
    def set_vehicle 
        @vehicle = Vehicle.find(params[:id])
    end    

    def vehicle_params
        params.require(:vehicle).permit(:registration_plate, :brand, :car_model, :model_year, :weight_capacity, :car_status, :modality_id) 
    end
end

