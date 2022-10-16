describe 'Usuário encerra uma ordem de serviço em andamento' do
    it 'dentro do prazo e vê detalhes' do
       #Arrange
       user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

       allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
       WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100, work_order_status: 1)  

       modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
       
       OpenWorkOrder.create!(modality_id: 1, work_order_id: 1, total_price: 1978, deadline_date: 5.days.from_now)
   
       #Act
       visit root_path 
       login_regular(user)
       click_on "Ordem de Serviço"
       click_on "Mais detalhes..."
       click_on "Encerrar ordem de serviço"
       fill_in 'Data em que o pedido foi entregue', with: 3.days.from_now 
       click_on 'Gravar'
    
        #Assert
        expect(page).to have_content('Ordem encerrada com sucesso')        
        expect(page).to have_content('Código da Entrega: ABC123456789456123')
        expect(page).to have_content('Encerrado no prazo')
        expect(page).to have_content('Detalhes da abertura do serviço:')
        expect(page).to have_content("Nome da Modalidade:\nShip from store")
        expect(page).to have_content("Preço total da entrega (R$):\n1978")
        expect(page).to have_content("Data prevista de entrega:")
        expect(page).to have_content(5.days.from_now.strftime("%d/%m/%Y"))
        expect(page).to have_content("Detalhes do Encerramento do serviço:")
        expect(page).to have_content("Data em que o pedido foi entregue:")
        expect(page).to have_content(3.days.from_now.strftime("%d/%m/%Y"))
        expect(page).to have_content("Motivo em caso de atraso:")
        expect(page).to have_content("Não há registro de motivo")
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
  
    it 'com atraso e vê detalhes' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
 
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100, work_order_status: 1)  
 
        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
        
        OpenWorkOrder.create!(modality_id: 1, work_order_id: 1, total_price: 1978, deadline_date: 5.days.from_now)
    
        #Act
        visit root_path 
        login_regular(user)
        click_on "Ordem de Serviço"
        click_on "Mais detalhes..."
        click_on "Encerrar ordem de serviço"
        fill_in 'Data em que o pedido foi entregue', with: 6.days.from_now 
        fill_in 'Motivo em caso de atraso', with: 'Houve um problema na transportadora durante a entrega'
        click_on 'Gravar'
     
         #Assert
         expect(page).to have_content('Ordem encerrada com sucesso')        
         expect(page).to have_content('Código da Entrega: ABC123456789456123')
         expect(page).to have_content('Encerrado com atraso')
         expect(page).to have_content('Detalhes da abertura do serviço:')
         expect(page).to have_content("Nome da Modalidade:\nShip from store")
         expect(page).to have_content("Preço total da entrega (R$):\n1978")
         expect(page).to have_content("Data prevista de entrega:")
         expect(page).to have_content(5.days.from_now.strftime("%d/%m/%Y"))
         expect(page).to have_content("Detalhes do Encerramento do serviço:")
         expect(page).to have_content("Data em que o pedido foi entregue:")
         expect(page).to have_content(6.days.from_now.strftime("%d/%m/%Y"))
         expect(page).to have_content("Motivo em caso de atraso:")
         expect(page).to have_content("Houve um problema na transportadora durante a entrega")
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

     it 'com atraso sem inserir motivo' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
 
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100, work_order_status: 1)  
 
        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
        
        OpenWorkOrder.create!(modality_id: 1, work_order_id: 1, total_price: 1978, deadline_date: 5.days.from_now)
    
        #Act
        visit root_path 
        login_regular(user)
        click_on "Ordem de Serviço"
        click_on "Mais detalhes..."
        click_on "Encerrar ordem de serviço"
        fill_in 'Data em que o pedido foi entregue', with: 6.days.from_now 
        fill_in 'Motivo em caso de atraso', with: ''
        click_on 'Gravar'
     
         #Assert
         expect(page).to have_content('Ordem não pode ser encerrada, digite o motivo.')        
         expect(page).to have_content('Encerrar ordem de serviço: ABC123456789456123')
         expect(page).to have_content('Data em que o pedido foi entregue')
         expect(page).to have_content('Motivo em caso de atraso')              
         
     end

     it 'com atraso sem inserir data' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
 
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345ADC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100, work_order_status: 1)  
 
        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
        
        OpenWorkOrder.create!(modality_id: 1, work_order_id: 1, total_price: 1978, deadline_date: 5.days.from_now)
    
        #Act
        visit root_path 
        login_regular(user)
        click_on "Ordem de Serviço"
        click_on "Mais detalhes..."
        click_on "Encerrar ordem de serviço"
        fill_in 'Data em que o pedido foi entregue', with: "" 
        fill_in 'Motivo em caso de atraso', with: ''
        click_on 'Gravar'
     
         #Assert
         expect(page).to have_content('Ordem não pode ser encerrada, a data em que o pedido foi entregue não pode ficar em branco')        
         expect(page).to have_content('Encerrar ordem de serviço: ABC123456789456123')
         expect(page).to have_content('Data em que o pedido foi entregue')
         expect(page).to have_content('Motivo em caso de atraso')              
         
     end
  
end