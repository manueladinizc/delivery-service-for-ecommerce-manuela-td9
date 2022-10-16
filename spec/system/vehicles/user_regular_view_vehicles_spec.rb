require 'rails_helper'

describe 'Usuário visita página de veículos' do
    it 'e vê o veículos cadastrados, mas não pode adicionar nem editar veículos' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

        Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
        #Act
        visit root_path 
        login_regular(user)
        click_on "Veículos"

        #Assert
        expect(page).to have_content('Veículos')
        expect(page).to have_content('Entrega Expressa')
        expect(page).not_to have_content('Adicionar Novo Veículo')
    end
    it 'e não existem modalidades cadastradas não pode adicionar veículos' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
        #Act
        visit root_path
        login_regular(user)
        click_on "Veículos"
        #Assert
        expect(page).to have_content('Não existe veículos cadastradas')
        expect(page).not_to have_content('Adicionar Novo Veículo')
    end


describe 'Usuário vê detalhes de um veículo' do
    it 'e vê informações adicionais com restrição para editar' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
       
        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

        Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality)
        #Act
        visit root_path
        login_regular(user)
        click_on "Veículos"
        #Assert
        expect(page).to have_content("Sprinter")
        expect(page).to have_content("Marca:\nMercedes-Benz")
        expect(page).to have_content("Ano:\n2017")
        expect(page).to have_content("Número de registro:\n123456")
        expect(page).to have_content("Capacidade de peso máxima:\n300Kg")
        expect(page).to have_content("Modalidade:\nEntrega Expressa")
        expect(page).to have_content("Em operação")
        expect(page).not_to have_content('Adicionar Novo Veículo')
        expect(page).not_to have_content('Editar')
    end
end
end