require 'rails_helper'

describe "Usuario faz uma requisicao de edição de um buffet" do
  
  it 'Faz um get não sendo dono do buffet' do 
    user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)

    user = User.create!(name: "Thais", last_name: "Silva", email: 'Silva@teste.com', password: 'teste123', company: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Thais', company_name: 'Thais Buffet', 
        cnpj: "65687954", phone: "959584302", email: 'Thais@teste.com', public_place: "Rua das pizzas", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "57899-621", complement: "Longe", description: "O melhor buffet", 
        payment_method: payment_method, user: user)

    login_as(user)
    get  edit_buffet_registration_path(event)

    expect(response).to redirect_to(root_path)
  end

  it 'Faz um patch sendo um cliente' do 
    user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)

    user = User.create!(name: "Thais", last_name: "Silva", email: 'Silva@teste.com', password: 'teste123', company: false)

    login_as(user)

    patch  buffet_registration_path(event), params: {"buffet_registration" => {"maximum_quantity" => "30"}}

    expect(response).to redirect_to(root_path)
  end

  it 'Faz um put sendo um visitante' do 
    user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)

    put  buffet_registration_path(event), params: {"buffet_registration" => {"maximum_quantity" => "30"}}

    expect(response).to redirect_to(new_user_session_path)
  end

end