require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validate' do
    it 'Nome obrigatório' do 
      user = User.new(name: "", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: false)

      expect(user.valid?).to eq false 
    end

    it 'Sobrenome obrigatório' do 
      user = User.new(name: "Eduarda", last_name: "", email: 'Eduarda@teste.com', password: 'teste123', company: false)

      expect(user.valid?).to eq false 
    end

    it 'Tipo de conta obrigatório' do 
      user = User.new(name: "Eduarda", last_name: "", company: nil, email: 'Eduarda@teste.com', password: 'teste123')

      expect(user.valid?).to eq false 
    end

    it 'CPF do cliente obrigatório' do 
      user = User.new(company: false)
      user.valid?
      result = user.errors.full_messages.include? "CPF não pode ficar em branco"
      expect(result).to eq true
    end

  end

  describe '#description' do 
    it 'Conta cliente' do 
      user = User.new(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: false)
      
      expect(user.description).to eq "Eduarda |Conta Cliente|"
    end

    it 'Conta Empresa' do 
      user = User.new(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      
      expect(user.description).to eq "Maria |Conta Empresa|"
    end
  end
end
