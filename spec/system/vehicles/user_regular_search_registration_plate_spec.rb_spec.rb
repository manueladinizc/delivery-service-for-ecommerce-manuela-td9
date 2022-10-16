require 'rails_helper'

describe 'Usuário administrador busca por um veículo' do
    it 'a partir do menu' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
        #Act
        visit root_path
        login_regular(user)
        click_on "Veículos"
        #Assert        
        expect(page).to have_field('Buscar Veículo')
        expect(page).to have_button('Buscar')
        
    end

    it 'e encontra um veículo' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
       
        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

        vehicle = Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
        
        #Act
        visit root_path
        login_regular(user)
        click_on "Veículos" 
        fill_in 'Buscar Veículo:', with: "123456"
        click_on 'Buscar'
       
        #Assert
        expect(page).to have_content "Resultado da Busca por: #{vehicle.registration_plate}"
        expect(page).to have_content '1 veículo encontrado'       
        expect(page).to have_content("Sprinter")
        expect(page).to have_content("Marca:\nMercedes-Benz")
        expect(page).to have_content("Ano:\n2017")
        expect(page).to have_content("Número de registro:\n123456")
        expect(page).to have_content("Capacidade de peso máxima:\n300Kg")
        expect(page).to have_content("Modalidade:\nEntrega Expressa")
        expect(page).to have_content("Em operação")
    end

    it 'e encontra múltiplos veículos' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
       
        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

        Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)

        Vehicle.create!(registration_plate: 123987, brand: "Renault", car_model: "Master", model_year: 2020, weight_capacity:500, car_status:1, modality: modality)

        Vehicle.create!(registration_plate: 103987, brand: "Renault", car_model: "Clio", model_year: 2020, weight_capacity:500, car_status:1, modality: modality)
        #Act
        visit root_path
        login_regular(user)
        click_on "Veículos" 
        fill_in 'Buscar Veículo:', with: "123"
        click_on 'Buscar'
       
        #Assert
        expect(page).to have_content('2 veículos encontrados')
        expect(page).to have_content('123456')
        expect(page).to have_content('123987')
        expect(page).not_to have_content('103987')
        expect(page).to have_content "Entrega Expressa"
          
    end

    
    it 'e não encontra nenhum registro para a busca' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
       
        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

        Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
                
        #Act
        visit root_path
        login_regular(user)
        click_on "Veículos" 
        fill_in 'Buscar Veículo:', with: "000000"
        click_on 'Buscar'
       
        #Assert
        expect(page).to have_content('0 veículos encontrados')
        expect(page).to have_content('Resultado da Busca por: 000000')  
        
          
    end

    it 'e não encontra nenhum registro para buscas com conteúdo vazio' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
       
        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

        Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
                
        #Act
        visit root_path
        login_regular(user)
        click_on "Veículos" 
        fill_in 'Buscar Veículo:', with: ""
        click_on 'Buscar'
       
        #Assert
        expect(page).to have_content('Resultado da Busca por:')
        expect(page).to have_content('Não há resultado para essa busca')  
        
          
    end
end