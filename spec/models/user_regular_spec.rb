require 'rails_helper'

RSpec.describe UserRegular, type: :model do
  describe '#description_regular' do
    it 'show eamil' do
    #Arrange
    user = UserRegular.new(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')
    #Act
    result = user.description_regular()
    #Assert
    expect(result).to eq('manu@sistemadefrete.com.br')
    end
  end
end
