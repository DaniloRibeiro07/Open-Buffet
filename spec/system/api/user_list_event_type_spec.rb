require 'rails_helper'

describe 'Usuário faz uma requisição para listar eventos de um buffet' do 
  context "api/v1/buffet_registrations/:buffet_registration_id/event_types" do

    it 'E o buffet não foi encontrado' do 
      get api_v1_buffet_registration_event_types_path(999999)
      expect(response.status).to eq 406
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to eq "Não há buffet com o id: 999999"
    end

    it 'E o buffet não possui eventos' do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)

      get api_v1_buffet_registration_event_types_path(1)
      expect(response.status).to eq 200
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 0
    end

    it 'E o buffet possui dois eventos' do 
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


      get api_v1_buffet_registration_event_types_path(1)
      expect(response.status).to eq 200
      expect(response.content_type).to include("json")
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first.keys.include?:created_at).to eq false
      expect(json_response.first.keys.include?:updated_at).to eq false
      expect(json_response.first.keys.include?:user_id).to eq false
      expect(json_response.first.keys.include?:working_day_price_id).to eq false
      expect(json_response.first.keys.include?:weekend_price_id).to eq false
      expect(json_response.first['id']).to eq event1.id
      expect(json_response.first['name']).to eq 'Aniversário'
      expect(json_response.first['description']).to eq 'Super aniversário para a sua familia e amigos'
      expect(json_response.first['minimum_quantity']).to eq 10
      expect(json_response.first['maximum_quantity']).to eq 15
      expect(json_response.first['duration']).to eq 60
      expect(json_response.first['menu']).to eq 'Bolo de aniversário, coxinha e salgados'
      expect(json_response.first['alcoholic_beverages']).to eq false
      expect(json_response.first['decoration']).to eq true
      expect(json_response.first['valet']).to eq true
      expect(json_response.first['insider']).to eq false
      expect(json_response.first['outsider']).to eq true
      expect(json_response.first['buffet_registration_id']).to eq buffet_registration.id
      expect(json_response.first['different_weekend']).to eq true
      expect(json_response.first['working_day_price']['base_price']).to eq 10
      expect(json_response.first['working_day_price']['price_per_person']).to eq 67
      expect(json_response.first['working_day_price']['overtime_rate']).to eq 44
      expect(json_response.first['weekend_price']['base_price']).to eq 50.39
      expect(json_response.first['weekend_price']['price_per_person']).to eq 30.25
      expect(json_response.first['weekend_price']['overtime_rate']).to eq 30.99

      expect(json_response.last['id']).to eq event2.id
      expect(json_response.last['name']).to eq 'Casamento'
      expect(json_response.last['description']).to eq 'Super casamento para jovens casais'
      expect(json_response.last['minimum_quantity']).to eq 30
      expect(json_response.last['maximum_quantity']).to eq 100
      expect(json_response.last['duration']).to eq 60
      expect(json_response.last['menu']).to eq 'Bolo, bebidas, crustáceos, e o que o casal desejar'
      expect(json_response.last['alcoholic_beverages']).to eq true
      expect(json_response.last['decoration']).to eq true
      expect(json_response.last['valet']).to eq true
      expect(json_response.last['insider']).to eq true
      expect(json_response.last['outsider']).to eq true
      expect(json_response.last['buffet_registration_id']).to eq buffet_registration.id
      expect(json_response.last['different_weekend']).to eq false
      expect(json_response.last['working_day_price']['base_price']).to eq 10
      expect(json_response.last['working_day_price']['price_per_person']).to eq 67
      expect(json_response.last['working_day_price']['overtime_rate']).to eq 44
      expect(json_response.last['weekend_price']['base_price']).to eq 10
      expect(json_response.last['weekend_price']['price_per_person']).to eq 67
      expect(json_response.last['weekend_price']['overtime_rate']).to eq 44
    end

  end
end