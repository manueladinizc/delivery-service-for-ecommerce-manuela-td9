require 'rails_helper'

describe 'Usuário visita página de tabela de prazos por distância' do
  it 'e cadastra novo intervalo' do
    user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

    modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

    visit root_path 
    login_adm(user)
    click_on "Modalidades"
    click_on "Tabelas de preços"
    click_on "Acessar tabela de configuração por prazos"
    fill_in 'Distância inicial do intervalo (Km)', with: 12
    fill_in 'Distância final do intervalo (Km)', with: 50
    fill_in 'Prazo (dias)', with: 10
    click_on 'Gravar'

    expect(page).to have_content('Tabela de configuração de prazos por distância')
    expect(page).to have_content('Cadastrar novo internavo')
    expect(page).to have_content('Distância (Km)')
    expect(page).to have_content('Prazo (dias)')
    expect(page).to have_content('Alterar Dados')
    expect(page).to have_content('12')
    expect(page).to have_content('50')
    expect(page).to have_content('10')
    expect(page).not_to have_content('Não existe dados para a tabela')
  end

  it 'e cadastra novo intervalo fora do limite da modalidade' do
    user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

    modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

    visit root_path 
    login_adm(user)
    click_on "Modalidades"
    click_on "Tabelas de preços"
    click_on "Acessar tabela de configuração por prazos"
    fill_in 'Distância inicial do intervalo (Km)', with: 1
    fill_in 'Distância final do intervalo (Km)', with: 55
    fill_in 'Prazo (dias)', with: 5
    click_on 'Gravar'

    expect(page).to have_content('Tabela de configuração de prazos por distância')
    expect(page).to have_content('Cadastrar novo internavo')
    expect(page).to have_content('Distância inicial do intervalo (Km) está fora do limite estabelecido pela modalidade de entrega')
    expect(page).to have_content('Distância final do intervalo (Km) está fora do limite estabelecido pela modalidade de entrega')
    
  end

  it 'e edita valor com sucesso' do
      #Arrange
      user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

      modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

      Deadline.create!(initial_interval:11, final_interval:18, duration:1, modality: modality_1 )
      
      #Act
      visit root_path 
      login_adm(user)
      click_on "Modalidades"
      click_on "Tabelas de preços"
      click_on "Acessar tabela de configuração por prazos"
      click_on "Editar"
      fill_in 'Distância inicial do intervalo (Km)', with: 12
      fill_in 'Distância final do intervalo (Km)', with: 20
      fill_in 'Prazo (dias)', with: 8
      click_on 'Gravar'


      #Assert
      expect(page).to have_content('Configuração de prazo por distância atualizado com sucesso')
      expect(page).to have_content('Tabela de configuração de prazos por distância')
      expect(page).to have_content('Distância (Km)')
      expect(page).to have_content('Prazo (dias)')
      expect(page).to have_content('Alterar Dados')
      expect(page).to have_content('12')
      expect(page).to have_content('20')
      expect(page).to have_content('8')

  end

  it 'e edita valor deixando informações em branco' do
    #Arrange
    user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

    modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

    Deadline.create!(initial_interval:12, final_interval:15, duration:1, modality: modality_1 )
    
    #Act
    visit root_path 
    login_adm(user)
    click_on "Modalidades"
    click_on "Tabelas de preços"
    click_on "Acessar tabela de configuração por prazos"
    click_on "Editar"
    fill_in 'Distância final do intervalo (Km)', with: 16
    fill_in 'Prazo (dias)', with: ''
    click_on 'Gravar'


    #Assert
    expect(page).to have_content('Não foi possível atualizar configuração de prazo por distância')
  end

  it 'e edita valor com intervalos já existente na tabela' do
    #Arrange
    user = UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

    modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

    Deadline.create!(initial_interval:11, final_interval:15, duration:1, modality: modality_1 )
    Deadline.create!(initial_interval:16, final_interval:20, duration:2, modality: modality_1 )
    
    #Act
    visit root_path 
    login_adm(user)
    click_on "Modalidades"
    click_on "Tabelas de preços"
    click_on "Acessar tabela de configuração por prazos"
    click_on "Editar", match: :first
    fill_in 'Distância inicial do intervalo (Km)', with: 17
    fill_in 'Distância final do intervalo (Km)', with: 18
    click_on 'Gravar'


    #Assert
    expect(page).to have_content('Distância inicial do intervalo (Km) já está contido em um intervalo')
    expect(page).to have_content('Distância final do intervalo (Km) já está contido em um intervalo')
  end
end