describe 'Usuário inicia uma ordem de serviço pendente' do
    it 'e vê detalhes da ordem de serviço' do
       #Arrange
       user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

       allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
       WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)     
       
       modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:0, maximum_weight:1000, flat_rate:15)
  
       Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality_1)
       Vehicle.create!(registration_plate: 987456, brand: "Kia", car_model: "Bongo", model_year: 2019, weight_capacity:800, car_status:0, modality: modality_1)
       Vehicle.create!(registration_plate: 123987, brand: "Renault", car_model: "Master", model_year: 2020, weight_capacity:500, car_status:1, modality: modality_1)
  
       WeightPrice.create!(initial_weight:0, final_weight:10, weight_rate:1, modality: modality_1 )
       WeightPrice.create!(initial_weight:11, final_weight:30, weight_rate:5, modality: modality_1 )
       WeightPrice.create!(initial_weight:31, final_weight:100, weight_rate:9, modality: modality_1 )
       WeightPrice.create!(initial_weight:101, final_weight:1000, weight_rate:13, modality: modality_1 )
  
       DistancePrice.create!(initial_distance:0, final_distance:50, distance_rate:2, modality: modality_1 )
       DistancePrice.create!(initial_distance:51, final_distance:150, distance_rate:9, modality: modality_1 )
       DistancePrice.create!(initial_distance:150, final_distance:800, distance_rate:13, modality: modality_1 )
  
       Deadline.create!(initial_interval:0, final_interval:50, duration:1, modality: modality_1 )
       Deadline.create!(initial_interval:51, final_interval:150, duration:5, modality: modality_1 )
       Deadline.create!(initial_interval:151, final_interval:800, duration:7, modality: modality_1 )
       Deadline.create!(initial_interval:801, final_interval:1500, duration:9, modality: modality_1 )
  
       #Act
       visit root_path 
       login_regular(user)
       click_on "Ordem de Serviço"
       click_on "Mais detalhes..."
       click_on "Iniciar Ordem de Serviço"
       select 'Ship from store', from: 'Modalidade'
       click_on 'Gravar'
    
     #Assert
    expect(page).to have_content('Ordem iniciada com sucesso')
    expect(page).to have_content('Código da Entrega: ABC123456789456123')
    expect(page).to have_content('Em andamento')
    expect(page).to have_content('Detalhes da abertura do serviço:')
    expect(page).to have_content("Nome da Modalidade:\nShip from store")
    expect(page).to have_content("Preço total da entrega (R$):\n924")
    expect(page).to have_content("Data prevista de entrega:")
    expect(page).to have_content(5.days.from_now.strftime("%d/%m/%Y"))
    expect(page).to have_content('Informações do produto:')
    expect(page).to have_content("Altura (cm):\n50")
    expect(page).to have_content("Comprimento (cm):\n50")
    expect(page).to have_content("Profundidade (cm):\n60")
    expect(page).to have_content("Peso (kg):\n80")
    expect(page).to have_content("Dados para Retirada:")
    expect(page).to have_content("Endereço de retirada:\nRua da Saudade, 10")    
    expect(page).to have_content("Cidade de retirada:\nRecife")  
    expect(page).to have_content("Estado de retirada:")
    expect(page).to have_content("PE")
    expect(page).to have_content("Dados para Entrega:")
    expect(page).to have_content("Nome do cliente:\nJoão")
    expect(page).to have_content("Endereço de entrega:\nAv. Boa viagem, 252")
    expect(page).to have_content("Cidade de entrega:\nRecife")    
    expect(page).to have_content("Distância (km):\n100")  
        
    end
  
end