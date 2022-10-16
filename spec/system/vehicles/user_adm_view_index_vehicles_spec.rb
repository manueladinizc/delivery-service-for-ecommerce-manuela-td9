require 'rails_helper'

describe 'Usuário visita página de veículos' do
    it 'e vê o veículos cadastrados' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

        Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
        #Act
        visit root_path 
        login_adm(user)
        click_on "Veículos"

        #Assert
        expect(page).to have_content('Veículos')
        expect(page).to have_content('Entrega Expressa')
    end
    it 'e não existem modalidades cadastradas' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
        #Act
        visit root_path
        login_adm(user)
        click_on "Veículos"
        #Assert
        expect(page).to have_content('Não existe veículos cadastradas')
    end


describe 'Usuário vê detalhes de um veículo' do
    it 'e vê informações adicionais' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
       
        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

        Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
        #Act
        visit root_path
        login_adm(user)
        click_on "Veículos"
        #Assert
        expect(page).to have_content("Sprinter")
        expect(page).to have_content("Marca:\nMercedes-Benz")
        expect(page).to have_content("Ano:\n2017")
        expect(page).to have_content("Número de registro:\n123456")
        expect(page).to have_content("Capacidade de peso máxima:\n300Kg")
        expect(page).to have_content("Modalidade:\nEntrega Expressa")
        expect(page).to have_content("Em operação")
    end
end
end