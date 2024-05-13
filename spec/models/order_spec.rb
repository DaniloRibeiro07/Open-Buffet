require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do 

    it 'O pedido deve ser aprovado antes da data de validade do pedido' do
      order = Order.new(final_value: 25, date: 2.day.from_now , expiration_date: Date.current)      
      order.status = "approved"
      order.valid?
      result = order.errors.full_messages.include? "Pedido vencido, pedido cancelado."
      expect(result).to eq true 
    end

    it 'O pedido deve ser aprovado antes da data de validade do pedido' do
      order = Order.new(final_value: 25, date: 2.day.from_now , expiration_date: 2.day.from_now)      
      order.status = "approved"
      order.valid?
      result = order.errors.full_messages.include? "Pedido vencido, pedido cancelado."
      expect(result).to eq false 
    end

    it 'Forma de pagamento obrigatório casa haja um valor no pedido' do
      order = Order.new(final_value: 25)
      order.valid?
      result = order.errors.full_messages.include? "Forma de pagamento deve ser especificado"
      expect(result).to eq true 
    end

    it 'Validade do pedido obrigatório, caso haja um valor no pedido' do
      order = Order.new(final_value: 25)
      order.valid?
      result = order.errors.full_messages.include? "Validade do Pedido deve ser menor ou igual a data do evento e maior ou igual a data de hoje"
      expect(result).to eq true 
    end

    it 'Validade do pedido não pode ser maior do que o data do evento' do
      order = Order.new(final_value: 25, date: 2.day.from_now , expiration_date: 3.day.from_now)
      order.valid?
      result = order.errors.full_messages.include? "Validade do Pedido deve ser menor ou igual a data do evento e maior ou igual a data de hoje"
      expect(result).to eq true 
    end

    it 'Validade do pedido não pode ser menor do que hoje' do
      order = Order.new(final_value: 25, date: 2.day.from_now , expiration_date: 1.day.ago)
      order.valid?
      result = order.errors.full_messages.include? "Validade do Pedido deve ser menor ou igual a data do evento e maior ou igual a data de hoje"
      expect(result).to eq true 
    end

    it 'Validade do pedido precisar ser maior ou igual a hoje e menor ou igual a data do evento' do
      order = Order.new(final_value: 25, date: 2.day.from_now , expiration_date: 1.day.from_now)
      order.valid?
      result = order.errors.full_messages.include? "Validade do Pedido deve ser menor ou igual a data do evento e maior ou igual a data de hoje"
      expect(result).to eq false 
    end

    it 'Valor final deve ser válido' do 
      order = Order.new(final_value: -5 )
      order.valid?

      result = order.errors.full_messages.include? "Valor Final precisa ser maior ou igual a 0"
      expect(result).to eq true 
    end

    it 'Valor final deve ser válido, como 0' do 
      order = Order.new(final_value: 0)
      order.valid?

      result = order.errors.full_messages.include? "Valor Final precisa ser maior ou igual a 0"
      expect(result).to eq false 
    end

    it 'Caso o valor final seja diferente do valor calculado, a justificativa é obrigatória' do 
      order = Order.new(final_value: 596, calculated_value: 300)
      order.valid?

      result = order.errors.full_messages.include? "Motivo do Valor Final precisa ser informada caso o valor seja diferente do calculado"
      expect(result).to eq true 
    end

    it 'Caso o valor final seja igual ao valor calculado, a justificativa é opcional' do 
      order = Order.new(final_value: 300, calculated_value: 300)
      order.valid?

      result = order.errors.full_messages.include? "Motivo do Valor Final precisa ser informada caso o valor seja diferente do calculado"
      expect(result).to eq false 
    end

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

      result = order.errors.full_messages.include? "Registro de um buffet não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'deve haver um tipo de evento' do 
      order = Order.new(event_type: nil)
      order.valid?

      result = order.errors.full_messages.include? "Tipo de Evento não pode ficar em branco"
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

    it 'Se o serviço for dentro do buffet, o evento precisa aceitar que o evento seja dentro do buffet' do 
      event = EventType.new(insider: false)
      order = Order.new(event_type: event, inside_the_buffet: true)
      order.valid? 
      result = order.errors.full_messages.include? "Dentro do Buffet? não pode ser dentro do buffet"
      expect(result).to eq true
    end
    
  end

  describe '#after_create' do
    it 'Deve haver um código de 8 digitos' do 
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
    end

    it 'O status inicial deve ser "Aguardando o buffet"' do 
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
      expect(order.status).to eq "waiting_for_buffet_review"
    end

    it 'Deve haver um valor calculado' do 
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
      expect(order.calculated_value).to eq 1280.4
    end

  end
end
