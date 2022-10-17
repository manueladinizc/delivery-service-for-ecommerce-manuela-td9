require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  describe '#valid?' do
      it 'must have code and status' do
               
        work_order = WorkOrder.new(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)    
      
       expect(work_order.valid?).to be true
      end
    end

  describe 'generate a valid code' do
       it 'when new work_orker is create' do
         #Arrange
         work_order = WorkOrder.new(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)  
         #Act
         work_order.save!
         result = work_order.delivery_code
         #Assert
         expect(result).not_to be_empty
         expect(result.length).to eq 15
        end
   
        it 'delivery_cod is unique' do
         #Arrange
         work_order_1 = WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)  
         work_order_2 = WorkOrder.new(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)  
         #Act
         work_order_2.save!
         #result = order.code
         #Assert
         expect(work_order_2.delivery_code).not_to eq work_order_1.delivery_code
         
        end


end
end