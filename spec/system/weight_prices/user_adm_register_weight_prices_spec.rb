require 'rails_helper'

describe 'Usuário visita página de tabela de preços por peso' do
  it 'e cadastra novo intervalo' do
    user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

    modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

    visit root_path 
    login_adm(user)
    click_on "Modalidades"
    click_on "Tabelas de preços"
    click_on "Acessar tabela de configuração do preço por peso"
    fill_in 'Peso inicial do intervalo (Kg)', with: 10
    fill_in 'Peso final do intervalo (Kg)', with: 15
    fill_in 'Valor por km (R$)', with: 5
    click_on 'Gravar'

    expect(page).to have_content('Tabela de configuração de preço por peso')
    expect(page).to have_content('Cadastrar novo internavo')
    expect(page).to have_content('Intervalo (Kg)')
    expect(page).to have_content('Valor por km (R$)')
    expect(page).to have_content('Alterar Dados')
    expect(page).to have_content('10')
    expect(page).to have_content('15')
    expect(page).to have_content('5')
    expect(page).not_to have_content('Não existe dados para a tabela')
  end

  it 'e cadastra novo intervalo fora do limite da modalidade' do
    user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

    modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

    visit root_path 
    login_adm(user)
    click_on "Modalidades"
    click_on "Tabelas de preços"
    click_on "Acessar tabela de configuração do preço por peso"
    fill_in 'Peso inicial do intervalo (Kg)', with: 5
    fill_in 'Peso final do intervalo (Kg)', with: 101
    fill_in 'Valor por km (R$)', with: 5
    click_on 'Gravar'

    expect(page).to have_content('Tabela de configuração de preço por peso')
    expect(page).to have_content('Cadastrar novo internavo')
    expect(page).to have_content('Peso inicial do intervalo (Kg) está fora do limite estabelecido pela modalidade de entrega')
    expect(page).to have_content('Peso final do intervalo (Kg) está fora do limite estabelecido pela modalidade de entrega')
    
  end

  it 'e edita valor com sucesso' do
      #Arrange
      user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

      modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

      WeightPrice.create!(initial_weight:10, final_weight:18, weight_rate:1, modality: modality_1 )
      
      #Act
      visit root_path 
      login_adm(user)
      click_on "Modalidades"
      click_on "Tabelas de preços"
      click_on "Acessar tabela de configuração do preço por peso"
      click_on "Editar"
      fill_in 'Peso inicial do intervalo (Kg)', with: 11
      fill_in 'Peso final do intervalo (Kg)', with: 19
      fill_in 'Valor por km (R$)', with: 5
      click_on 'Gravar'


      #Assert
      expect(page).to have_content('Tabela de configuração de preço por peso')
      expect(page).to have_content('Intervalo (Kg)')
      expect(page).to have_content('Valor por km (R$)')
      expect(page).to have_content('Alterar Dados')
      expect(page).to have_content('11')
      expect(page).to have_content('19')
      expect(page).to have_content('5')

  end

  it 'e edita valor deixando informações em branco' do
    #Arrange
    user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

    modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

    WeightPrice.create!(initial_weight:10, final_weight:15, weight_rate:1, modality: modality_1 )
    
    #Act
    visit root_path 
    login_adm(user)
    click_on "Modalidades"
    click_on "Tabelas de preços"
    click_on "Acessar tabela de configuração do preço por peso"
    click_on "Editar"
    fill_in 'Peso final do intervalo (Kg)', with: 16
    fill_in 'Valor por km (R$)', with: ''
    click_on 'Gravar'


    #Assert
    expect(page).to have_content('Não foi possível atualizar configuração de preço por peso')
  end

  it 'e edita valor com intervalos já existente na tabela' do
    #Arrange
    user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

    modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

    WeightPrice.create!(initial_weight:10, final_weight:15, weight_rate:1, modality: modality_1 )
    WeightPrice.create!(initial_weight:16, final_weight:20, weight_rate:2, modality: modality_1 )
    
    #Act
    visit root_path 
    login_adm(user)
    click_on "Modalidades"
    click_on "Tabelas de preços"
    click_on "Acessar tabela de configuração do preço por peso"
    click_on "Editar", match: :first
    fill_in 'Peso inicial do intervalo (Kg)', with: 17
    fill_in 'Peso final do intervalo (Kg)', with: 18
    click_on 'Gravar'


    #Assert
    expect(page).to have_content('Peso inicial do intervalo (Kg) já está contido em um intervalo')
    expect(page).to have_content('Peso final do intervalo (Kg) já está contido em um intervalo')
  end
end