require 'rails_helper'

describe 'Usuário visita página de ordem de serviço' do
    it 'e vê o códigos da ordem de serviço' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)
        
        
        #Act
        visit root_path 
        login_adm(user)
        click_on "Ordem de Serviço"

        #Assert
        expect(page).to have_content('Código')
        expect(page).to have_content('Status')
        expect(page).to have_content('Mais detalhes...')
        expect(page).to have_content('ABC123456789456123')
        expect(page).to have_content('Mais detalhes...')
        expect(page).to have_content('Pendente')
    end
    it 'e não existem existe ordem de serviço cadastrada' do
         #Arrange
         user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
                
         
         #Act
         visit root_path 
         login_adm(user)
         click_on "Ordem de Serviço"
        #Assert
        expect(page).to have_content('Não existe ordem de serviço cadastrada')
    end
end

describe 'Usuário vê detalhes de uma ordem de serviço' do
    it 'com sucesso' do
     #Arrange
     user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

     allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
     WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)     
     
     #Act
     visit root_path 
     login_adm(user)
     click_on "Ordem de Serviço"
     click_on "Mais detalhes..."
    
     #Assert
    expect(page).to have_content('Código da Entrega: ABC123456789456123')
    expect(page).to have_content('Informações do produto:')
    expect(page).to have_content("Altura (cm):\n50")
    expect(page).to have_content("Peso (kg):\n80")
    expect(page).to have_content("Altura (cm):\n50")
    expect(page).to have_content("Dados para Retirada:")
    expect(page).to have_content("Nome do cliente:\nJoão")
    expect(page).to have_content("Distância (km):\n100")
        
    end
end