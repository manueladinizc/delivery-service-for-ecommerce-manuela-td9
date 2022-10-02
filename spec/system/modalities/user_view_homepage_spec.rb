require 'rails_helper'

describe 'Usuário visita tela inicial' do
    it 'e vê o nome do app' do
        #Arrange
        #user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')
        #Act
        visit(root_path)
        #login_as(user)
        #Assert
        expect(page).to have_content('Sistema de Frete')
        expect(page).to have_link('Sistema de Frete', href: root_path)
    end
end