require 'rails_helper'

RSpec.describe CustomerAddress, type: :model do
  describe '#valid' do 
    it 'Logradouro obrigatório' do 
      address = CustomerAddress.new(public_place: nil)
      address.valid?
      result = address.errors.full_messages.include? "Logradouro não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'Número obrigatório' do 
      address = CustomerAddress.new(address_number: nil)
      address.valid?
      result = address.errors.full_messages.include? "N° não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'Bairro obrigatório' do 
      address = CustomerAddress.new(neighborhood: nil)
      address.valid?
      result = address.errors.full_messages.include? "Bairro não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'Estado obrigatório' do 
      address = CustomerAddress.new(state: nil)
      address.valid?
      result = address.errors.full_messages.include? "Bairro não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'Cidade obrigatório' do 
      address = CustomerAddress.new(city: nil)
      address.valid?
      result = address.errors.full_messages.include? "Cidade não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'CEP obrigatório' do 
      address = CustomerAddress.new(zip: nil)
      address.valid?
      result = address.errors.full_messages.include? "CEP não pode ficar em branco"
      expect(result).to eq true 
    end

  end
end
