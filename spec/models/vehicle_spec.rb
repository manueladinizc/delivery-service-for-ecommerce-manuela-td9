require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when registration_plate is empty' do
        modality = Modality.create(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15) 
        vehicle = Vehicle.new(registration_plate: '', brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
        
        expect(vehicle.valid?).to eq false
      end 

      it 'false when brand is empty' do
        modality = Modality.create(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15) 
        vehicle = Vehicle.new(registration_plate: '123456', brand: "", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
        
        expect(vehicle.valid?).to eq false
      end 

      it 'false when car_model is empty' do
        modality = Modality.create(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15) 
        vehicle = Vehicle.new(registration_plate: '123456', brand: "Mercedes-Benz", car_model: "", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
        
        expect(vehicle.valid?).to eq false
      end 

      it 'false when model_year is empty' do
        modality = Modality.create(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15) 
        vehicle = Vehicle.new(registration_plate: '123456', brand: "Mercedes-Benz", car_model: "Sprinter", model_year: '', weight_capacity:300, car_status:0, modality: modality)
        
        expect(vehicle.valid?).to eq false
      end 

      it 'false when weight_capacity is empty' do
        modality = Modality.create(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15) 
        vehicle = Vehicle.new(registration_plate: '123456', brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:'', car_status:0, modality: modality)
        
        expect(vehicle.valid?).to eq false
      end 

      it 'false when car_status is empty' do
        modality = Modality.create(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15) 
        vehicle = Vehicle.new(registration_plate: '123456', brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:'', modality: modality)
        
        expect(vehicle.valid?).to eq false
      end 

      it 'false when registration_plate is already in use' do
        #Arrange
        modality = Modality.create(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15) 
        
        vehicle_1 = Vehicle.create(registration_plate: '123456', brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:'', modality: modality)
        vehicle_2 = Vehicle.new(registration_plate: '123456', brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:'', modality: modality)
                
        expect(vehicle_2.valid?).to eq false
      end
      
    end
  end
end
