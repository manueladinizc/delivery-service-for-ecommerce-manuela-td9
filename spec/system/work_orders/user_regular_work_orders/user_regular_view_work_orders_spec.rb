require 'rails_helper'

describe 'Usuário visita página de ordem de serviço' do
    it 'e vê o códigos da ordem de serviço pendente' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)
        
        #Act
        visit root_path 
        login_regular(user)
        click_on "Ordem de Serviço"

        #Assert
        expect(page).to have_content('Código')
        expect(page).to have_content('Status')
        expect(page).to have_content('Iniciar ordem e ver detalhes do pedido')
        expect(page).to have_content('Mais detalhes...')
        expect(page).to have_content('ABC123456789456123')        
        expect(page).to have_content('Pendente')        
        expect(page).to have_content('Buscar Ordem de Serviço')
        expect(page).to have_content('Ver apenas ordens de serviço pendentes')
        expect(page).not_to have_content('Criar Ordem de Serviço')
    end

    it 'e vê apenas ordens de serviço pendentes em uma tela separada' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)


        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('DEF123456789456123')
        WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345VVC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100, work_order_status: 2)   
        
        OpenWorkOrder.create!(modality_id: 1, work_order_id: 2, total_price: 1978, deadline_date: 5.days.from_now)
        CloseWorkOrder.create!(work_order_id: 2, delivery_date: 4.days.from_now)
        
        #Act
        visit root_path 
        login_regular(user)
        click_on "Ordem de Serviço"
        click_on "Ver apenas ordens de serviço pendentes"

        #Assert
        expect(page).to have_content('Código')
        expect(page).to have_content('Status')
        expect(page).to have_content('Iniciar ordem e ver detalhes do pedido')
        expect(page).to have_content('Mais detalhes...')
        expect(page).to have_content('ABC123456789456123')        
        expect(page).to have_content('Pendente')        
       
    end

    it 'e não existem existe ordem de serviço cadastrada' do
         #Arrange
         user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')        
         #Act
         visit root_path 
         login_regular(user)
         click_on "Ordem de Serviço"
        #Assert
        expect(page).to have_content('Não existe ordem de serviço cadastrada')
        expect(page).to have_content('Buscar Ordem de Serviço')
        expect(page).not_to have_content('Criar Ordem de Serviço')
    end
end

describe 'Usuário vê detalhes de uma ordem de serviço pendente' do
    it 'com sucesso' do
     #Arrange
     user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
     
     allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
     WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)
     
     #Act
     visit root_path 
     login_regular(user)
     click_on "Ordem de Serviço"
     click_on "Mais detalhes..."
    
     #Assert
    expect(page).to have_content('Código da Entrega: ABC123456789456123')
    expect(page).to have_content('Pendente')
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