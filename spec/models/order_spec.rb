require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do 

    it 'Duração do evento obrigatória' do
      order = Order.new
      order.valid?

      result = order.errors.full_messages.include? "Duração do Evento (minutos) não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'Duração deve ser maior que 1 minuto' do
      order = Order.new(duration:0 )
      order.valid?

      result = order.errors.full_messages.include? "Duração do Evento (minutos) deve ser maior que 1"
      expect(result).to eq true 
    end

    it 'A data deve ser obrigatória' do
      order = Order.new
      order.valid?

      result = order.errors.full_messages.include? "Data não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'A data deve ser maior do que hoje' do
      order = Order.new(date: Date.current)
      order.valid?

      result = order.errors.full_messages.include? "Data deve ser maior do que hoje (#{I18n.l Date.current})"
      expect(result).to eq true 
    end

    it 'A data deve ser maior do que hoje - 2 ' do
      order = Order.new(date: 1.day.ago)
      order.valid?

      result = order.errors.full_messages.include? "Data deve ser maior do que hoje (#{I18n.l Date.current})"
      expect(result).to eq true 
    end

    it 'A data deve ser maior do que hoje' do
      order = Order.new(date: 1.day.from_now)
      order.valid?

      result = order.errors.full_messages.include? "Data deve ser maior do que hoje (#{I18n.l Date.current})"
      expect(result).to eq false 
    end

    it 'deve haver um buffet' do 
      order = Order.new(buffet_registration: nil)
      order.valid?

      result = order.errors.full_messages.include? "Registro de um buffet é obrigatório(a)"
      expect(result).to eq true 
    end

    it 'deve haver um tipo de evento' do 
      order = Order.new(event_type: nil)
      order.valid?

      result = order.errors.full_messages.include? "Tipo de Evento é obrigatório(a)"
      expect(result).to eq true 
    end

    it 'Dentro do buffet ? obrigatório' do 
      order = Order.new(inside_the_buffet: nil)
      order.valid?

      result = order.errors.full_messages.include? "Dentro do Buffet? não está incluído na lista"
      expect(result).to eq true 
    end

    it 'Dentro do buffet ? pode ser falso' do 
      order = Order.new(inside_the_buffet: false)
      order.valid?

      result = order.errors.full_messages.include? "Dentro do Buffet? não está incluído na lista"
      expect(result).to eq false 
    end

    it 'Dentro do buffet ? pode ser true' do 
      order = Order.new(inside_the_buffet: true)
      order.valid?

      result = order.errors.full_messages.include? "Dentro do Buffet? não está incluído na lista"
      expect(result).to eq false 
    end


    it 'Quantidade de pessoas deve ser menor ou igual do que a quantidade máxima do evento' do
      event = EventType.new(maximum_quantity: 100)
      order = Order.new(event_type: event, amount_of_people: 101)
      order.valid? 
      result = order.errors.full_messages.include? "Participantes do Evento Deve ser menor ou igual a 100"
      expect(result).to eq true
    end

    it 'Quantidade de pessoas deve ser maior ou igual do que a quantidade mínima do evento' do
      event = EventType.new(minimum_quantity: 10)
      order = Order.new(event_type: event, amount_of_people: 9)
      order.valid? 
      result = order.errors.full_messages.include? "Participantes do Evento Deve ser maior ou igual a 10"
      expect(result).to eq true
    end

    it 'O endereço do cliente deve ser especificado se o evento não for dentro do buffet' do
      order = Order.new(inside_the_buffet: false) 
      order.valid? 
      result = order.errors.full_messages.include? "Endereço do cliente obrigatório"
      expect(result).to eq true 
    end

    it 'O endereço do cliente não é necessário se o evento for dentro do buffet' do
      order = Order.new(inside_the_buffet: true) 
      order.valid? 
      result = order.errors.full_messages.include? "Endereço do cliente obrigatório"
      expect(result).to eq false 
    end

    it 'O attributo user precisa ser um cliente' do
      user = User.new(company: true)
      order = Order.new(user: user) 
      order.valid? 
      result = order.errors.full_messages.include? "Usuário precisa ser um cliente"
      expect(result).to eq true 
    end
    
  end

  describe '#after_create' do
    it 'Deve haver um código de 8 digitos e o status inicial deve ser "Aguardando avaliação"' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)

      payment_method = PaymentMethod.create!(pix: true)
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: false, decoration: true, valet: false, insider: true, outsider: false, user: user)

      client = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      client.build_client_datum(cpf: "97498970058")
      client.save!

      order = Order.create!(buffet_registration: buffet_registration, event_type: event, duration: 30, amount_of_people: 51, 
                            date: 1.day.from_now, inside_the_buffet: true, user: client)
      expect(order.nil?).to eq false 
      expect(order.code.length).to eq 8 
      expect(order.status).to eq "waiting_for_review"
    end
  end
end
