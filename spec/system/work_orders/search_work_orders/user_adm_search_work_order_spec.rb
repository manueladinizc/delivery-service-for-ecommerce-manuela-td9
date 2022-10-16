require 'rails_helper'

describe 'Usuário administrador busca por uma ordem de serviço' do
    it 'a partir do menu' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
        #Act
        visit root_path
        login_adm(user)
        click_on "Ordem de Serviço"
        click_on "Buscar Ordem de Serviço"
        #Assert        
        expect(page).to have_field('Buscar ordem de serviço:')
        expect(page).to have_button('Buscar')
        
    end

    it 'e encontra uma ordem de serviço' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        work_order = WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100)             
        
        #Act
        visit root_path
        login_adm(user)
        click_on "Ordem de Serviço"
        click_on "Buscar Ordem de Serviço"
        fill_in 'Buscar ordem de serviço:', with: "ABC123456789456123"
        click_on 'Buscar'
       
        #Assert
        expect(page).to have_content "Resultado da Busca por: #{work_order.delivery_code}"
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

    
    it 'e não encontra nenhum registro para a busca' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state:'PE', distance:100)   
        #Act
        visit root_path
        login_adm(user)
        click_on "Ordem de Serviço"
        click_on "Buscar Ordem de Serviço"
        fill_in 'Buscar ordem de serviço:', with: "0000000000000BB"
        click_on 'Buscar'
              
        #Assert
        expect(page).to have_content('Não há resultado para essa busca')
        
          
    end

    it 'e não encontra nenhum registro para buscas com conteúdo vazio' do
         #Arrange
         user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

         allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
         WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state:'PE', distance:100)   
         #Act
         visit root_path
         login_adm(user)
         click_on "Ordem de Serviço"
         click_on "Buscar Ordem de Serviço"
         fill_in 'Buscar ordem de serviço:', with: ""
         click_on 'Buscar'
               
         #Assert
         expect(page).to have_content('Não há resultado para essa busca')       
          
    end
end