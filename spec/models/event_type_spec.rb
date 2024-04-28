require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe '#valid' do 
    it "Cadastro correto" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value

      event = EventType.new( weekend_price: event_value, working_day_price: event_value , name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user, buffet_registration: buffet_registration)
      expect(event.valid?).to eq true  
    end

    it "Nome Obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value

      event = EventType.new( weekend_price: event_value, working_day_price: event_value ,name: "", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Descrição Obrigatória" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value

      event = EventType.new( weekend_price: event_value, working_day_price: event_value ,name: "Aniversário", description: "",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Quantidade minima de pessoas Obrigatória" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value

      event = EventType.new( weekend_price: event_value, working_day_price: event_value ,name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: nil, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Quantidade máxima de pessoas Obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new( weekend_price: event_value, working_day_price: event_value ,name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: nil, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Duração Obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new( weekend_price: event_value, working_day_price: event_value ,name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: nil, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Cardápio Obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new( weekend_price: event_value, working_day_price: event_value ,name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "", 
              alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Insider ou Outsider Obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new( weekend_price: event_value, working_day_price: event_value ,name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: false, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Insider ou Outsider Obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new( weekend_price: event_value, working_day_price: event_value, buffet_registration: buffet_registration , name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: true, outsider: false, user: user)
      
      expect(event.valid?).to eq true  
    end

    it "Insider ou Outsider Obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new( weekend_price: event_value, working_day_price: event_value, buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)
      
      expect(event.valid?).to eq true  
    end

    it "User Obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new( weekend_price: event_value, working_day_price: event_value ,name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: nil)
      
      expect(event.valid?).to eq false  
    end

    it "Registro do buffet Obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new( weekend_price: event_value, working_day_price: event_value ,name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "A quantidade maxima de participantes n pode ser menor que a quantidade minima" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new( weekend_price: event_value, working_day_price: event_value , name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 20, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Valores em dias úteis é obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new(weekend_price: event_value, buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
              minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
              alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end

    it "Valores no final de semana é obrigatório" do 
      user, payment_method, buffet_registration, event_value = create_user_payment_buffet_event_value
      
      event = EventType.new(working_day_price: event_value, different_weekend: true , buffet_registration: buffet_registration, name: "Aniversário", 
              description: "Super aniversário para a sua familia e amigos", minimum_quantity: 10, maximum_quantity: 15, 
              duration: 60, menu: "Bolo de aniversário, coxinha e salgados",  alcoholic_beverages: false, 
              decoration: true, valet: true, insider: false, outsider: true, user: user)
      
      expect(event.valid?).to eq false  
    end
  end
end
