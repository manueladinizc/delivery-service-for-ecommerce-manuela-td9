require 'rails_helper'

describe 'Usuário visita página de tabela de preços por peso' do
  it 'e edita valor' do
      #Arrange
      user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

      modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

      WeightPrice.create!(initial_weight:0, final_weight:10, weight_rate:1, modality: modality_1 )
      
      #Act
      visit root_path 
      login_adm(user)
      click_on "Modalidades"
      click_on "Tabelas de preços"
      click_on "Acessar tabela de configuração do preço por peso"
      click_on "Editar"
      fill_in 'Peso final do intervalo (Kg)', with: 12
      fill_in 'Valor por km (R$)', with: 5
      click_on 'Gravar'


      #Assert
      expect(page).to have_content('Tabela de configuração de preço por peso')
      expect(page).to have_content('Intervalo (Kg)')
      expect(page).to have_content('Valor por km (R$)')
      expect(page).to have_content('Alterar Dados')
      expect(page).to have_content('0')
      expect(page).to have_content('12')
      expect(page).to have_content('5')

  end

#   it 'e edita valor deixando informações em branco' do
#     #Arrange
#     user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

#     modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

#     WeightPrice.create!(initial_weight:0, final_weight:10, weight_rate:1, modality: modality_1 )
    
#     #Act
#     visit root_path 
#     login_adm(user)
#     click_on "Modalidades"
#     click_on "Tabelas de preços"
#     click_on "Acessar tabela de configuração do preço por peso"
#     click_on "Editar"
#     fill_in 'Peso final do intervalo (Kg)', with: 12
#     fill_in 'Valor por km (R$)', with: ''
#     click_on 'Gravar'


#     #Assert
#     expect(page).to have_content('Não foi possível atualizar configuração de preço por peso')
# end
end