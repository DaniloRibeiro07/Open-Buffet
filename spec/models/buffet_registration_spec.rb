require 'rails_helper'

RSpec.describe BuffetRegistration, type: :model do
  describe '#valid' do 
    it 'Conta válida' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq true
    end

    it 'Nome Fantasia obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: '', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'Razão social obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: '', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'CNPJ obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: nil, phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'Telefone obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: nil, email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'Email obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: '', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'Logradouro obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: '', address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'Numero residencial obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: 'Rua das aguas', address_number: "", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'Bairro obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: 'Rua das aguas', address_number: "25A", neighborhood: "", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'Estado obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: 'Rua das aguas', address_number: "25A", neighborhood: "São Lucas", 
        state: "", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'Cidade obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: 'Rua das aguas', address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'CEP obrigatório' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: 'Rua das aguas', address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

    it 'Descrição obrigatória' do 
      user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: 'Rua das aguas', address_number: "25A", neighborhood: "São Lucas", 
        state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "", 
        payment_method: payment_method, user: user)
      
      expect(buffet_registration.valid?).to eq false
    end

  end

  describe '#full_address' do 
    it 'Resultado esperado' do
      buffet_registration = BuffetRegistration.new(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira")

      result = buffet_registration.full_address

      expect(result).to eq "Rua das flores, 25A, 48750-621, São Paulo-SP"
    end
  end
end
