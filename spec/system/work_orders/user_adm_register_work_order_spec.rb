require 'rails_helper'

describe 'Usuário cadastra uma ordem de serviço' do
    it 'a partir da tela de cadastro ordem de serviço' do
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
              
        click_on 'Ordem de Serviço'
        click_on 'Criar Ordem de Serviço'
        #Assert
        expect(page).to have_content('Criar Ordem de Serviço')
        expect(page).to have_content('Informações do produto:')
        expect(page).to have_field('Código do produto')
        expect(page).to have_field('Altura')
        expect(page).to have_field('Comprimento')
        expect(page).to have_content('Dados para Retirada:')
        expect(page).to have_field('Endereço de retirada')
        expect(page).to have_field('Cidade de retirada')
        expect(page).to have_content('Dados para Entrega:')
        expect(page).to have_field('Cidade de entrega')
        expect(page).to have_field('Distância')
        
        
    end


    it 'com sucesso' do
        
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
        
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        #Act
        visit root_path
        click_on 'Entrar como usuário administrador'
        within('form') do
            fill_in 'E-mail', with: 'manuela@sistemadefrete.com.br'
            fill_in 'Senha', with: 'password'
            click_on 'Entrar'
        end
              
        click_on 'Ordem de Serviço'
        click_on 'Criar Ordem de Serviço' 
        fill_in 'Código do produto', with: '12345A'
        fill_in 'Altura', with: 80
        fill_in 'Comprimento', with: 50
        fill_in 'Profundidade', with: 10
        fill_in 'Peso', with: 10
        fill_in 'Endereço de retirada', with: "Rua da Saudade, 10"
        fill_in 'Cidade de retirada', with: "Recife"
        fill_in 'Estado de retirada', with: "PE"
        fill_in 'Nome do cliente', with: "Maria"
        fill_in 'Endereço de entrega', with: "Rua da lua, 110"
        fill_in 'Cidade de entrega', with: "Recife"
        fill_in 'Estado de entrega', with: "PE"
        fill_in 'Distância', with: "110"
        
        
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq work_orders_path
        expect(page).to have_content 'Ordem de serviço cadastrada com sucesso'
        expect(page).to have_content 'ABC123456789456123'
        expect(page).to have_content 'Pendente'
        
        end
        
    it 'com dados incompletos' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
        
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789456123')
        #Act
        visit root_path
        click_on 'Entrar como usuário administrador'
        within('form') do
            fill_in 'E-mail', with: 'manuela@sistemadefrete.com.br'
            fill_in 'Senha', with: 'password'
            click_on 'Entrar'
        end
              
        click_on 'Ordem de Serviço'
        click_on 'Criar Ordem de Serviço' 

        fill_in 'Código do produto', with: '12345A'
        fill_in 'Altura', with: 80
        fill_in 'Comprimento', with: 50
        fill_in 'Profundidade', with: 10
        fill_in 'Peso', with: ''
        fill_in 'Endereço de retirada', with: ""
        fill_in 'Cidade de retirada', with: "Recife"
        fill_in 'Estado de retirada', with: "PE"
        fill_in 'Nome do cliente', with: "Maria"
        fill_in 'Endereço de entrega', with: "Rua da lua, 110"
        fill_in 'Cidade de entrega', with: ""
        fill_in 'Estado de entrega', with: "PE"
        fill_in 'Distância', with: "110"
        
        
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Ordem de serviço não cadastrado.'
        expect(page).to have_content 'Cidade de entrega não pode ficar em branco'                                       
        expect(page).to have_content 'Endereço de retirada não pode ficar em branco'                                     
                                                  
    end
 end
