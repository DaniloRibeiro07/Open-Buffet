require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe '#valid' do 
    it "Cadastro correto" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(pix: true)
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira")
      event = EventType.new(name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user, buffet_registration: buffet_registration)
      
      expect(event.valid?).to eq true  
    end

    it "Nome Obrigatório" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Descrição Obrigatória" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "Aniversário", description: "",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Quantidade minima de pessoas Obrigatória" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: nil, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Quantidade máxima de pessoas Obrigatório" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: nil, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Duração Obrigatório" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: nil, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Cardápio Obrigatório" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Insider ou Outsider Obrigatório" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: false, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Insider ou Outsider Obrigatório" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(pix: true)
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira")
      
      event = EventType.new(buffet_registration: buffet_registration , name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: true, outsider: false, user: user)
      
      expect(event.valid?).to eq true  
    end

    it "Insider ou Outsider Obrigatório" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(pix: true)
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira")
      event = EventType.new(buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)
      
      expect(event.valid?).to eq true  
    end

    it "User Obrigatório" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: nil)
      
      expect(event.valid?).to eq false  
    end

    it "Registro do buffet Obrigatório" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    

    it "A quantidade maxima de participantes n pode ser menor que a quantidade minima" do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      event = EventType.new(name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 20, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end
  end
end
