require 'rails_helper'

describe 'Usuário faz uma requisição para listar buffets através da API' do 
  context 'GET /api/v1/buffet_registrations/?filter=' do 
    
    it 'com sucesso, porém, sem registros' do 
      get api_v1_buffet_registrations_path

      expect(response.status).to eq 200
      expect(response.content_type).to include("json")

      json_response = JSON.parse(response.body)

      expect(json_response.count).to eq 0
    end

    it 'com sucesso, sem filtro' do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      user2 = User.create!(name: "Antônia", last_name: "Fernanda", email: 'Antônia@teste.com', password: 'teste123', company: true)
      buffet_registration2 = BuffetRegistration.create!(trading_name: 'Buffet Astrônomo', company_name: 'Fernanda Buffet', 
        cnpj: "568498723", phone: "715863246", email: 'fernada@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
        state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet dos ares", 
        payment_method: payment_method, user: user2)
      
      get api_v1_buffet_registrations_path

      expect(response.status).to eq 200
      expect(response.content_type).to include("json")

      json_response = JSON.parse(response.body)

      expect(json_response.count).to eq 2 
      expect(json_response.first).to eq 'Buffet da familia'
      expect(json_response.last).to eq 'Buffet Astrônomo'
    end

    it 'com sucesso, com filtro' do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      user2 = User.create!(name: "Antônia", last_name: "Fernanda", email: 'Antônia@teste.com', password: 'teste123', company: true)
      buffet_registration2 = BuffetRegistration.create!(trading_name: 'Buffet Astrônomo', company_name: 'Fernanda Buffet', 
        cnpj: "568498723", phone: "715863246", email: 'fernada@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
        state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet dos ares", 
        payment_method: payment_method, user: user2)

      user = User.create!(name: "Nanda", last_name: "Antonia", email: 'Nanda@teste.com', password: 'teste123', company: true)
      buffet_registration3 = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet familia feliz', company_name: 'Alegria Buffet', 
        cnpj: "96901808000119", phone: "7995876812", email: 'Nanda@teste.com', public_place: "Quadra 1406 Sul Alameda 7", address_number: "36",
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77025-195", complement: "Próximo ao clube do sargento", description: "O buffet mais alegre da região")
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration3, name: "Famosa Festa", description: "A festa famosa que a galera precisa",
        minimum_quantity: 10, maximum_quantity: 443, duration: 223, menu: "Churrasco de mais", 
        alcoholic_beverages: true, decoration: true, valet: false, insider: true, outsider: false, user: user)
          
      
      get api_v1_buffet_registrations_path+"/?filter=familia"

      expect(response.status).to eq 200
      expect(response.content_type).to include("json")

      json_response = JSON.parse(response.body)

      expect(json_response.count).to eq 2
      expect(json_response.first).to eq 'Buffet da familia'
      expect(json_response.last).to eq 'Buffet familia feliz'

    end

    it 'há registros, porem não foi encontrado' do 
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
        state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
        payment_method: payment_method, user: user)
      user2 = User.create!(name: "Antônia", last_name: "Fernanda", email: 'Antônia@teste.com', password: 'teste123', company: true)
      buffet_registration2 = BuffetRegistration.create!(trading_name: 'Buffet Astrônomo', company_name: 'Fernanda Buffet', 
        cnpj: "568498723", phone: "715863246", email: 'fernada@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
        state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet dos ares", 
        payment_method: payment_method, user: user2)
      
      get api_v1_buffet_registrations_path+"/?filter=alegria"

      expect(response.status).to eq 406
      expect(response.content_type).to include("json")

      json_response = JSON.parse(response.body)

      expect(json_response['errors']).to eq 'Não foi encontrados registros de alegria'
    end
  end
end