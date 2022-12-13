require 'rails_helper'

describe 'Usuário visita página de tabela de prazos' do
    it 'e vê a tabela cadastrada' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 0, maximum_distance:2000, minimum_weight:10, maximum_weight:100, flat_rate:15)

        Deadline.create!(initial_interval:0, final_interval:50, duration:1, modality: modality_1 )
        Deadline.create!(initial_interval:51, final_interval:150, duration:2, modality: modality_1 )
        Deadline.create!(initial_interval:151, final_interval:800, duration:3, modality: modality_1 )
        Deadline.create!(initial_interval:801, final_interval:1500, duration:4, modality: modality_1 )
                
        #Act
        visit root_path 
        login_adm(user)
        click_on "Modalidades"
        click_on "Tabelas de preços"
        click_on "Acessar tabela de configuração por prazos"


        #Assert
        expect(page).to have_content('Tabela de configuração de prazos por distância')
        expect(page).to have_content('Distância (Km)')
        expect(page).to have_content('Prazo (dias)')
        expect(page).to have_content('151')
        expect(page).to have_content('801')

    end
    it 'e não existem dados cadastrados' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
        #Act
        visit root_path 
        login_adm(user)
        click_on "Modalidades"
        click_on "Tabelas de preços"
        click_on "Acessar tabela de configuração por prazos"
        #Assert
        expect(page).to have_content('Não existe dados para a tabela')
    end
end