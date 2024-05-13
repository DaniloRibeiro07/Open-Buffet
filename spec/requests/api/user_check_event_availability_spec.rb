require 'rails_helper'

describe 'Usuário faz um post requisitando a disponibilidade do evento' do 
  context '/api/v1/event_types/:event_type_id/orders' do 
    it 'e Não existe um evento com o ID informado' do 
      post api_v1_event_type_orders_path(9999)

      expect(response.status).to eq 406
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to eq "Não há um tipo de evento com o id: 9999"
    end

    it 'e Há um Evento e não há pedidos confirmados no dia, consulta com sucesso' do
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)

      event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
      event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)
  
      event1 = EventType.create!(different_weekend: true , weekend_price: event_value_weekend, working_day_price: event_value_working, 
        buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos", 
        minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: true, outsider: true, user: user)

      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!

      extra_service = ExtraService.new(decoration: true)
      order = Order.create!(user: cliente, event_type: event1, buffet_registration: buffet_registration, date: 11.day.from_now, 
                            amount_of_people: 14, duration: 35, inside_the_buffet: true, extra_service: extra_service,
              final_value: 55, justification_final_value: "Imposto", expiration_date: 10.day.from_now, payment_method: "pix")
      order.approved!
  
      post api_v1_event_type_orders_path(buffet_registration.id), params: {'date': 5.day.from_now, 'amount_of_people': 13}

      calculated_value = Order.new(event_type: event1, amount_of_people: 13, duration: 2, date: 5.day.from_now).calculate_calculated_value

      expect(response.status).to eq 200
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response['prior_value']).to eq calculated_value
    end

    it 'e Há um Evento e há um pedido no mesmo dia, consulta com falha' do
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true, boleto:true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!

      extra_service = ExtraService.new(decoration: true)
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
              final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")
      order.approved!
  
      post api_v1_event_type_orders_path(buffet_registration.id), params: {'date': 1.day.from_now, 'amount_of_people': 13}

      expect(response.status).to eq 409
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to eq "Já há um pedido aprovado neste dia"
    end

    it 'e esquece os parâmetros' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true, boleto:true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)
  
      post api_v1_event_type_orders_path(buffet_registration.id)

      expect(response.status).to eq 412
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include "Data não pode ficar em branco"
      expect(json_response['errors']).to include "Participantes do Evento não pode ficar em branco"
    end

    it 'com a quantidade de pessoas fora do limite superior' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true, boleto:true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)
  
      post api_v1_event_type_orders_path(buffet_registration.id), params: {'date': 5.day.from_now, 'amount_of_people': 300}

      expect(response.status).to eq 412
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).not_to include "Data deve ser maior do que hoje (#{I18n.l Date.current})"
      expect(json_response['errors']).to include "Participantes do Evento Deve ser menor ou igual a 55"
    end

    it 'com a quantidade de pessoas fora do limite inferior e a data antes de hoje' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true, boleto:true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)
  
      post api_v1_event_type_orders_path(buffet_registration.id), params: {'date': 1.day.ago, 'amount_of_people': 1}

      expect(response.status).to eq 412
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include "Participantes do Evento Deve ser maior ou igual a 10"
      expect(json_response['errors']).to include "Data deve ser maior do que hoje (#{I18n.l Date.current})"
    end


    it 'E ocorre uma falha interna do servidor' do 
      allow(EventType).to receive(:find_by).and_raise(ActiveRecord::ActiveRecordError)
      
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true, boleto:true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)
  
      post api_v1_event_type_orders_path(buffet_registration.id)


      expect(response.status).to eq 500
      
    end
  end
end