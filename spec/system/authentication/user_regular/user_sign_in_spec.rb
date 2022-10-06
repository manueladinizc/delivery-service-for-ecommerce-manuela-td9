require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        #Arrange
        UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
        #Act
        visit root_path
        click_on 'Entrar como usuário regular'
        within('form') do
            fill_in 'E-mail', with: 'manu@sistemadefrete.com.br'
            fill_in 'Senha', with: 'password'
            click_on 'Entrar'
        end

        #Assert
        expect(page).to have_content 'Login efetuado com sucesso.'        
        expect(page).not_to have_content 'Entrar como usuário regular'
        expect(page).to have_button 'Sair'
        expect(page).to have_content 'manu@sistemadefrete.com.br'
        
    end

    it 'e faz logout' do
        #Arrange
        UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
        #Act
        visit root_path
        click_on 'Entrar como usuário regular'
        within('form') do
            fill_in 'E-mail', with: 'manu@sistemadefrete.com.br'
            fill_in 'Senha', with: 'password'
            click_on 'Entrar'
        end
        click_on 'Sair'
        #Assert
        expect(page).to have_content 'Logout efetuado com sucesso.'
        expect(page).to have_content 'Entrar como usuário administrador'
        expect(page).to have_content 'Entrar como usuário regular'
        #expect(page).to have_content 'Consultar entrega'
        expect(page).not_to have_button 'Sair'
        expect(page).not_to have_content 'manuela@sistemadefrete.com.br'
end
    
end    