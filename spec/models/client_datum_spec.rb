require 'rails_helper'

RSpec.describe ClientDatum, type: :model do
  describe "#valid" do 
    it 'CPF com comprimento incorreto (10)' do 
      client = ClientDatum.new(cpf: "1236547890")
      client.valid?
      result = client.errors.full_messages.include? "CPF não possui o tamanho esperado (11 caracteres)"
      expect(result).to eq true
    end

    it 'CPF com comprimento correto (11)' do 
      client = ClientDatum.new(cpf: "12365478901")
      client.valid?
      result = client.errors.full_messages.include? "CPF não possui o tamanho esperado (11 caracteres)"
      expect(result).to eq false
    end

    it 'CPF com comprimento incorreto (12)' do 
      client = ClientDatum.new(cpf: "123654789012")
      client.valid?
      result = client.errors.full_messages.include? "CPF não possui o tamanho esperado (11 caracteres)"
      expect(result).to eq true
    end

    it 'CPF Banido' do 
      client = ClientDatum.new(cpf: "01234567890")
      client.valid?
      result = client.errors.full_messages.include? "CPF inválido"
      expect(result).to eq true
    end

    it 'CPF invalido' do 
      client = ClientDatum.new(cpf: "01234567850")
      client.valid?
      result = client.errors.full_messages.include? "CPF inválido"
      expect(result).to eq true
    end

    it 'CPF correto' do 
      client = ClientDatum.new(cpf: "03865429025")
      client.valid?
      result = client.errors.full_messages.include? "CPF inválido"
      expect(result).to eq false
    end

    it 'Probido CPF repetido' do 
      visitante = User.new(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
      visitante.build_client_datum(cpf: "02241335002")
      visitante.save!

      client = ClientDatum.new(cpf: "02241335002")
      client.valid?
      result = client.errors.full_messages.include? "CPF já está em uso"
      expect(result).to eq true
    end

  end
end
