require 'rails_helper'

RSpec.describe Modality, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        modality = Modality.new(name: '', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)        
        
        expect(modality.valid?).to eq false
      end 

      it 'false when minimum_distance is empty' do
        modality = Modality.new(name: 'Ship from store', minimum_distance:'' , maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)

        expect(modality.valid?).to eq false
      end 

      it 'false when maximum_distance is empty' do
        modality = Modality.new(name: 'Ship from store', minimum_distance: 10, maximum_distance:'', minimum_weight:10, maximum_weight:100, flat_rate:15)
        
        expect(modality.valid?).to eq false
      end 

      it 'false when minimum_weight is empty' do
        modality = Modality.new(name: 'Ship from store', minimum_distance: 10, maximum_distance:100, minimum_weight:'', maximum_weight:100, flat_rate:15)
        
        expect(modality.valid?).to eq false
      end 

      it 'false when maximum_weight is empty' do
        modality = Modality.new(name: 'Ship from store', minimum_distance: 10, maximum_distance:100, minimum_weight:10, maximum_weight:'', flat_rate:15)
        
        expect(modality.valid?).to eq false
      end 

      it 'false when flat_rate is empty' do
        modality = Modality.new(name: 'Ship from store', minimum_distance: 10, maximum_distance:100, minimum_weight:10, maximum_weight:200, flat_rate:'')
        
        expect(modality.valid?).to eq false
      end 

      it 'false when name is already in use' do
       
        first_modality = Modality.create(name: 'Ship from store', minimum_distance: 10, maximum_distance:100, minimum_weight:10, maximum_weight:200, flat_rate:'10')

        second_modality = Modality.new(name: 'Ship from store', minimum_distance: 10, maximum_distance:100, minimum_weight:10, maximum_weight:200, flat_rate:'15')
       
        expect(second_modality.valid?).to eq false
      end    
    end
  end
end
