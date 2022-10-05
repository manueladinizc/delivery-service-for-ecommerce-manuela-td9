require 'rails_helper'

describe 'Usuário visita página de modalidades' do
    it 'e vê o Modalidades de Frete Cadastrados' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

        Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
        Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)
        #Act
        login_as(user)
        visit root_path 
        click_on "Modalidades"

        #Assert
        expect(page).to have_content('Modalidades de Transporte')
        expect(page).to have_content('Ship from store')
        expect(page).to have_content('Entrega Expressa')
        expect(page).not_to have_content('Adicionar Nova Modalidade')
        expect(page).not_to have_content('Editar')
        
    end
    it 'e não existem modalidades cadastradas' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
        #Act
        login_as(user)
        visit root_path
        click_on "Modalidades"
        #Assert
        expect(page).to have_content('Não existe modalidades de transporte cadastradas')
        expect(page).not_to have_content('Adicionar Nova Modalidade')
        
    end
end

describe 'Usuário vê detalhes de uma modalidade' do
    it 'e vê informações adicionais' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
        Modality.create!(name: 'Same day delivery', minimum_distance: 3, maximum_distance:10, minimum_weight:0, maximum_weight:20, flat_rate:10, modality_status: "disabled")
        #Act
        login_as(user)
        visit root_path
        click_on "Modalidades"
        #Assert
        expect(page).to have_content('Same day delivery')
        expect(page).to have_content("Distância mínima:\n3km")
        expect(page).to have_content("Distância máxima:\n10km")
        expect(page).to have_content("Peso mínimo:\n0kg")
        expect(page).to have_content("Peso máximo:\n20kg")
        expect(page).to have_content("Taxa fixa:\nR$10")
        expect(page).to have_content("Desativado")
        expect(page).not_to have_content('Adicionar Nova Modalidade')
        expect(page).not_to have_content('Editar')
    end
end