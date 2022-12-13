require 'rails_helper'

describe 'Usuário visita página de tabela de preços por peso' do
    it 'e vê a tabela cadastrada' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:0, maximum_weight:1000, flat_rate:15)

        WeightPrice.create!(initial_weight:0, final_weight:10, weight_rate:1, modality: modality_1 )
        WeightPrice.create!(initial_weight:11, final_weight:30, weight_rate:2, modality: modality_1 )
        WeightPrice.create!(initial_weight:31, final_weight:100, weight_rate:3, modality: modality_1 )
        WeightPrice.create!(initial_weight:101, final_weight:1000, weight_rate:4, modality: modality_1 )
        
        #Act
        visit root_path 
        login_regular(user)
        click_on "Modalidades"
        click_on "Tabelas de preços"
        click_on "Acessar tabela de configuração do preço por peso"


        #Assert
        expect(page).to have_content('Tabela de configuração de preço por peso')
        expect(page).to have_content('Intervalo (Kg)')
        expect(page).to have_content('Valor por km (R$)')
        expect(page).to have_content('101')
        expect(page).to have_content('30')

    end
    it 'e não existem dados cadastrados' do
        #Arrange
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
        #Act
        visit root_path 
        login_regular(user)
        click_on "Modalidades"
        click_on "Tabelas de preços"
        click_on "Acessar tabela de configuração do preço por peso"
        #Assert
        expect(page).to have_content('Não existe dados para a tabela')
    end

    it 'e não vê área de cadastro ou editar tabela' do
        user = UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

        modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:0, maximum_weight:1000, flat_rate:15)

        WeightPrice.create!(initial_weight:0, final_weight:10, weight_rate:1, modality: modality_1 )
        WeightPrice.create!(initial_weight:11, final_weight:30, weight_rate:2, modality: modality_1 )
        WeightPrice.create!(initial_weight:31, final_weight:100, weight_rate:3, modality: modality_1 )
        WeightPrice.create!(initial_weight:101, final_weight:1000, weight_rate:4, modality: modality_1 )
        
        #Act
        visit root_path 
        login_regular(user)
        click_on "Modalidades"
        click_on "Tabelas de preços"
        click_on "Acessar tabela de configuração do preço por peso"


        #Assert
        expect(page).to have_content('Tabela de configuração de preço por peso')
        expect(page).to have_content('Intervalo (Kg)')
        expect(page).to have_content('Valor por km (R$)')
        expect(page).to have_content('0')
        expect(page).to have_content('10')
        expect(page).to have_content('1')
        expect(page).to have_content('1')
        expect(page).not_to have_content('Alterar Dados')
        expect(page).not_to have_content('Editar')
        expect(page).not_to have_content('Cadastrar novo internavo ')
        expect(page).not_to have_content('Peso inicial do intervalo (Kg)')
        expect(page).not_to have_content('Peso final do intervalo (Kg)')
        within('form') do
        expect(page).not_to have_content('Valor por km (R$')
        end
    end
end

