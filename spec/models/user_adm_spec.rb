require 'rails_helper'

RSpec.describe UserAdm, type: :model do
  describe '#description_adm' do
    it 'show eamil' do
    #Arrange
    user = UserAdm.new(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')
    #Act
    result = user.description_adm()
    #Assert
    expect(result).to eq('manuela@sistemadefrete.com.br')
    end
  end
end
