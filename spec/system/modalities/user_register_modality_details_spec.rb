require 'rails_helper'

describe 'Usuário cadastra uma modalidade' do
    it 'a partir da tela inicial' do
        #Arrange
        
        #Act
        visit root_path
        click_on 'Sistema de Frete'
        click_on 'Adicionar Nova Modalidade'
        #Assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Taxa fixa')
        expect(page).to have_field('Distância mínima')
        expect(page).to have_field('Distância máxima')
        expect(page).to have_field('Peso mínimo')
        expect(page).to have_field('Peso máximo')
        expect(page).to have_field('Status')
    end

    it 'com sucesso' do
        #Arrange
        
        #Act
        visit root_path
        click_on 'Sistema de Frete'
        click_on 'Adicionar Nova Modalidade'
        
        fill_in 'Nome', with: 'Same day delivery'
        fill_in 'Taxa fixa', with: 10
        fill_in 'Distância mínima', with: 8
        fill_in 'Distância máxima', with: 10
        fill_in 'Peso mínimo', with: 10
        fill_in 'Peso máximo', with: 19
        select "activated", from: 'Status'
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Modalidade cadastrado com sucesso.'
        expect(page).to have_content 'Same day delivery'
        expect(page).to have_content 'Ativo'
        expect(page).to have_content '10'
        end
        
    it 'com dados incompletos' do
        #Arrange
        
        #Act
        visit root_path
        click_on 'Sistema de Frete'
        click_on 'Adicionar Nova Modalidade'
        fill_in 'Nome', with: ''
        fill_in 'Taxa fixa', with: 10
        fill_in 'Distância mínima', with:''
        fill_in 'Distância máxima', with: 10
        fill_in 'Peso mínimo', with: 10
        fill_in 'Peso máximo', with: ''
        select "activated", from: 'Status'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Modalidade não cadastrado.'
        expect(page).to have_content 'Nome não pode ficar em branco'                                       
        expect(page).to have_content 'Distância mínima não pode ficar em branco'                                     
        expect(page).to have_content "Peso máximo não pode ficar em branco"                                          
    end
end
