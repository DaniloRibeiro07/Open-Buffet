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

    it 'com sucesso, sem filtro e não exibe desabilitados' do 
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

      user3 = User.create!(name: "Anônimo", last_name: "Desativado", email: 'desativador@teste.com', password: 'teste123', company: true)
      buffet_registration3 = BuffetRegistration.create!(available: :desactive, trading_name: 'Buffet Desativado', company_name: 'Anonimo Desativado', 
        cnpj: "568498703", phone: "715863246", email: 'Anonimo@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
        state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet dos desativados", 
        payment_method: payment_method, user: user3)
      
      get api_v1_buffet_registrations_path

      expect(response.status).to eq 200
      expect(response.content_type).to include("json")

      json_response = JSON.parse(response.body)

      expect(json_response.count).to eq 2 
      expect(json_response.first['id']).to eq 1
      expect(json_response.first['trading_name']).to eq 'Buffet da familia'
      expect(json_response.first['city']).to eq 'São Paulo'
      expect(json_response.first['state']).to eq 'SP'
      expect(json_response.last['id']).to eq 2
      expect(json_response.last['trading_name']).to eq 'Buffet Astrônomo'
      expect(json_response.last['city']).to eq 'Salvador'
      expect(json_response.last['state']).to eq 'BA'
    end

    it 'com sucesso, com filtro e não exibe desabilitados' do 
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
      
      user4 = User.create!(name: "Anonimo", last_name: "Desabilitado", email: 'Anonimo@teste.com', password: 'teste123', company: true)
      buffet_registration4 = BuffetRegistration.create!(available: :desactive, user: user4, payment_method: payment_method, trading_name: 'Buffet familia Anonimo', company_name: 'Alegria Buffet', 
        cnpj: "96901808000319", phone: "7995876812", email: 'Anonimo@teste.com', public_place: "Quadra 1406 Sul Alameda 7", address_number: "36",
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77025-195", complement: "Próximo ao clube do sargento", description: "O buffet mais alegre da região")

      
      get api_v1_buffet_registrations_path+"/?filter=familia"

      expect(response.status).to eq 200
      expect(response.content_type).to include("json")

      json_response = JSON.parse(response.body)

      expect(json_response.count).to eq 2 
      expect(json_response.first['id']).to eq 1
      expect(json_response.first['trading_name']).to eq 'Buffet da familia'
      expect(json_response.first['city']).to eq 'São Paulo'
      expect(json_response.first['state']).to eq 'SP'
      expect(json_response.last['id']).to eq 3
      expect(json_response.last['trading_name']).to eq 'Buffet familia feliz'
      expect(json_response.last['city']).to eq 'Palmas'
      expect(json_response.last['state']).to eq 'TO'
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
      
      get api_v1_buffet_registrations_path, params:{'filter': 'alegria'}

      expect(response.status).to eq 406
      expect(response.content_type).to include("json")

      json_response = JSON.parse(response.body)

      expect(json_response['errors']).to eq 'Não foi encontrados registros de alegria'
    end

    it 'E ocorre uma falha interna do servidor' do 
      
      user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
      payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
      buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
      
      allow(BuffetRegistration).to receive(:active).and_raise(ActiveRecord::ActiveRecordError)

      get api_v1_buffet_registration_path(buffet_registration.id)


      expect(response.status).to eq 500
    end
  end
end