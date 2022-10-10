require 'rails_helper'

describe 'Usuário visita página de tabela de preços por distância' do
    it 'e vê a tabela cadastrada' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

        DistancePrice.create!(initial_distance:0, final_distance:50, distance_rate:9, modality: modality_1 )
        DistancePrice.create!(initial_distance:51, final_distance:150, distance_rate:12, modality: modality_1 )
        DistancePrice.create!(initial_distance:150, final_distance:800, distance_rate:20, modality: modality_1 )
        
        #Act
        login_as(user)
        visit root_path 
        click_on "Modalidades"
        click_on "Tabelas de preços"
        click_on "Acessar tabela de configuração do preço por distância"


        #Assert
        expect(page).to have_content('Tabela de configuração de preço por distância')
        expect(page).to have_content('Intervalo (km)')
        expect(page).to have_content('Taxa (R$)')
        expect(page).to have_content('0')
        expect(page).to have_content('800')

    end
    it 'e não existem dados cadastrados' do
        #Arrange
        user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
        #Act
        login_as(user)
        visit root_path 
        click_on "Modalidades"
        click_on "Tabelas de preços"
        click_on "Acessar tabela de configuração do preço por peso"
        #Assert
        expect(page).to have_content('Não existe dados para a tabela')
    end
end