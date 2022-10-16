require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        #Arrange
        #Act
        visit root_path
        click_on 'Entrar como usuário regular'
        click_on 'Criar uma conta'       
        fill_in 'Nome', with: 'Manuela'
        fill_in 'E-mail', with: 'manu@sistemadefrete.com.br'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        #Assert
        expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
        expect(page).to have_content 'manu@sistemadefrete.com.br'
        expect(page).to have_button 'Sair'
        user = UserRegular.last 
        expect(user.name).to eq 'Manuela'
    end
    it 'com email fora do domain permitido' do
        #Arrange
        #Act
        visit root_path
        click_on 'Entrar como usuário regular'
        click_on 'Criar uma conta'       
        fill_in 'Nome', with: 'Manuela'
        fill_in 'E-mail', with: 'manu@frete.com.br'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        #Assert
        expect(page).to have_content 'Não foi possível salvar usuário: 1 erro'
        expect(page).to have_content 'Email deve possuir domain: @sistemadefrete.com.br'        
    end
end