require 'rails_helper'

describe 'O usuário faz uma requisição para obter detalhes de um buffet' do 
  context '/api/v1/buffet_registrations/:id' do 
    it 'e o id do buffet não existe' do 
      get api_v1_buffet_registration_path(999999)

      expect(response.status).to eq 406
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to eq "Não há buffet com o id: 999999"
    end

    it 'buffet existente com eventos' do 
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
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)

      event2 = EventType.create!(different_weekend: false , weekend_price: event_value_working, working_day_price: event_value_working,
        buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais",
        minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
        
      
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!

      extra_service = ExtraService.new(decoration: true)
      order1 = Order.create!(user: cliente, event_type: event2, buffet_registration: buffet_registration, date: 1.day.from_now, 
              amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
              final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")
      
      order1.create_evaluation!(score: 3, comment: "Ambiente insalubre")

      order2 = Order.create!(user: cliente, event_type: event2, buffet_registration: buffet_registration, date: 1.day.from_now, 
        amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
        final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")

      order2.create_evaluation!(score: 5, comment: "Comida muito gostosa")

    
      get api_v1_buffet_registration_path(buffet_registration.id)
      
      expect(response.status).to eq 200
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response.keys.include?'created_at').to eq false
      expect(json_response.keys.include?'updated_at').to eq false 
      expect(json_response.keys.include?'cnpj').to eq false 
      expect(json_response.keys.include?'company_name').to eq false 
      expect(json_response.keys.include?'user_id').to eq false 
      expect(json_response.keys.include?'payment_method_id').to eq false 
      expect(json_response['trading_name']).to eq 'Buffet da familia'
      expect(json_response['phone']).to eq '7995876812'
      expect(json_response['email']).to eq 'Eduarda@teste.com'
      expect(json_response['public_place']).to eq 'Rua das flores'
      expect(json_response['address_number']).to eq '25A'
      expect(json_response['neighborhood']).to eq 'São Lucas'
      expect(json_response['state']).to eq 'SP'
      expect(json_response['city']).to eq 'São Paulo'
      expect(json_response['zip']).to eq '48750-621'
      expect(json_response['complement']).to eq ''
      expect(json_response['description']).to eq 'O melhor buffet da familia brasileira'
      expect(json_response['payment_method']['pix']).to eq true
      expect(json_response['payment_method']['bank_transfer']).to eq true
      expect(json_response['payment_method']['money']).to eq true
      expect(json_response['payment_method']['bitcoin']).to eq true
      expect(json_response['payment_method']['debit_card']).not_to eq true
      expect(json_response['payment_method']['debit_card']).not_to eq true
      expect(json_response['event_types'].length).to eq 2
      expect(json_response['event_types'].first.keys.length).to eq 2
      expect(json_response['event_types'].first['name']).to eq 'Aniversário'
      expect(json_response['event_types'].first['id']).to eq event1.id
      expect(json_response['event_types'].last['name']).to eq 'Casamento'
      expect(json_response['event_types'].last['id']).to eq event2.id
      expect(json_response['average']).to eq '4.0'
    end

    it 'buffet existente sem eventos' do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)

      get api_v1_buffet_registration_path(buffet_registration.id)
      
      expect(response.status).to eq 200
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)

      expect(json_response['event_types'].length).to eq 0
    end

    it 'buffet existente sem eventos desabilitado' do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      buffet_registration = BuffetRegistration.create!(available: :desactive, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)

      get api_v1_buffet_registration_path(buffet_registration.id)
      
      expect(response.status).to eq 406
    end

    it 'E ocorre uma falha interna do servidor' do 
      allow(BuffetRegistration).to receive(:active).and_raise(ActiveRecord::ActiveRecordError)
      
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)

      get api_v1_buffet_registration_path(buffet_registration.id)


      expect(response.status).to eq 500
      
    end
  end
end