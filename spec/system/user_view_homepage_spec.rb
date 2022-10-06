require 'rails_helper'

describe 'Usuário visita tela inicial' do
    it 'e vê informações da tela inicial' do
        #Arrange        
        #Act
        visit(root_path)        
        #Assert
        expect(page).to have_content('Sistema de Frete')
        expect(page).to have_content('Entrar como usuário administrador')
        expect(page).to have_content('Entrar como usuário regular')
        #expect(page).to have_content('Consultar entrega')
    end 

    
    
end