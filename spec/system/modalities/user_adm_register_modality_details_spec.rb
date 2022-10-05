require 'rails_helper'

describe 'Usuário cadastra uma modalidade' do
    it 'a partir da tela de cadastro de modalidades' do
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
        click_on 'Modalidades'
        click_on 'Adicionar Nova Modalidade'
        #Assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Taxa fixa')
        expect(page).to have_field('Distância mínima')
        expect(page).to have_field('Distância máxima')
        expect(page).to have_field('Peso mínimo')
        expect(page).to have_field('Peso máximo')
        expect(page).to have_content('Status:')
        
        
    end

    it 'com sucesso' do
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
        click_on 'Modalidades'
        click_on 'Adicionar Nova Modalidade'
        
        fill_in 'Nome', with: 'Same day delivery'
        fill_in 'Taxa fixa', with: 10
        fill_in 'Distância mínima', with: 8
        fill_in 'Distância máxima', with: 10
        fill_in 'Peso mínimo', with: 10
        fill_in 'Peso máximo', with: 19
        find("label", text: "Desativado").click
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq modalities_path
        expect(page).to have_content 'Modalidade cadastrado com sucesso.'
        expect(page).to have_content 'Same day delivery'
        expect(page).to have_content 'Desativado'
        expect(page).to have_content '10'
        end
        
    it 'com dados incompletos' do
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
        click_on 'Modalidades'
        click_on 'Adicionar Nova Modalidade'
        fill_in 'Nome', with: ''
        fill_in 'Taxa fixa', with: 10
        fill_in 'Distância mínima', with:''
        fill_in 'Distância máxima', with: 10
        fill_in 'Peso mínimo', with: 10
        fill_in 'Peso máximo', with: ''
        find("label", text: "Ativo").click
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Modalidade não cadastrado.'
        expect(page).to have_content 'Nome não pode ficar em branco'                                       
        expect(page).to have_content 'Distância mínima não pode ficar em branco'                                     
        expect(page).to have_content "Peso máximo não pode ficar em branco"                                          
    end
end
