require 'rails_helper'

describe 'Usuário cadastra uma modalidade' do
    it 'a partir da de cadastro de veículos' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
        #Act
        visit root_path
        click_on 'Entrar como usuário administrador'
        within('form') do
            fill_in 'E-mail', with: 'manuela@sistemadefrete.com.br'
            fill_in 'Senha', with: 'password'
            click_on 'Entrar'
        end
        click_on 'Veículos'
        click_on 'Adicionar Novo Veículo'
        #Assert
        
        expect(page).to have_content("Adicionar Novo Veículo")
        expect(page).to have_content("Modelo")
        expect(page).to have_content("Marca")
        expect(page).to have_content("Ano")
        expect(page).to have_content("Número de registro")
        expect(page).to have_content("Capacidade de peso máxima (kg)")
        expect(page).to have_content("Modalidade:")
        expect(page).to have_content("Status:")
        
        
    end

    it 'com sucesso' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

        #Act
        visit root_path
        click_on 'Entrar como usuário administrador'
        within('form') do
            fill_in 'E-mail', with: 'manuela@sistemadefrete.com.br'
            fill_in 'Senha', with: 'password'
            click_on 'Entrar'
        end
        click_on 'Veículos'
        click_on 'Adicionar Novo Veículo'
        
        fill_in 'Modelo', with: 'Strada'
        fill_in 'Marca', with: "Fiat "
        fill_in 'Ano', with: 2018
        fill_in 'Número de registro', with: 113264
        fill_in 'Capacidade de peso máxima', with: 1000
        find("label", text: "Em operação").click
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq vehicles_path
        expect(page).to have_content 'Veículo cadastrado com sucesso.'
        expect(page).to have_content 'Strada'
        expect(page).to have_content 'Fiat'
        expect(page).to have_content '2018'
        end
        
    it 'com dados incompletos' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        modality = Modality.create!(name: 'Entrega Expressa', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)
        #Act
        visit root_path
        click_on 'Entrar como usuário administrador'
        within('form') do
            fill_in 'E-mail', with: 'manuela@sistemadefrete.com.br'
            fill_in 'Senha', with: 'password'
            click_on 'Entrar'
        end
        click_on 'Veículos'
        click_on 'Adicionar Novo Veículo'
        fill_in 'Modelo', with: 'Strada'
        fill_in 'Marca', with: ''
        fill_in 'Ano', with: ''
        fill_in 'Número de registro', with: 113264
        fill_in 'Capacidade de peso máxima', with: ''
        find("label", text: "Em operação").click
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Veículo não cadastrado.'
        expect(page).to have_content 'Marca não pode ficar em branco'                                       
        expect(page).to have_content 'Ano não pode ficar em branco'                                     
        expect(page).to have_content "Capacidade de peso máxima não pode ficar em branco"                                          
        end
end

