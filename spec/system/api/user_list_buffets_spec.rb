require 'rails_helper'

describe 'Usuário faz uma requisição para listar buffets através da API' do 
  context 'GET /api/v1/buffet_registrations/?filter=' do 
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
  end
end