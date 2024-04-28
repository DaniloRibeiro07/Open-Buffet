require 'rails_helper'

describe "Usuario faz uma requisicao de criação de um buffet" do
  it "GET Sendo uma conta empresa já possuindo um buffet" do 
    user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: user)

    login_as(user)

    get new_buffet_registration_path

    expect(response).to redirect_to(root_path)
  end

  it "POST Sendo uma conta empresa já possuindo um buffet" do 
    user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: user)

    login_as(user)

    post buffet_registrations_path, params: {"buffet_registration" => {"maximum_quantity" => "30"}}

    expect(response).to redirect_to(root_path)
  end

  it "Get sendo um visitante" do 
    get  new_buffet_registration_path

    expect(response).to redirect_to(new_user_session_path)
  end

  it "Post sendo um visitante" do 
    post buffet_registrations_path, params: {"buffet_registration" => {"maximum_quantity" => "30"}}

    expect(response).to redirect_to(new_user_session_path)
  end

  it "get sendo um cliente" do 
    user = User.new(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: false)
    user.build_client_datum(cpf: "02241335002")
    user.save!
    login_as(user)

    get  new_buffet_registration_path

    expect(response).to redirect_to(root_path)
  end

  it "Post sendo um cliente" do 
    user = User.new(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: false)
    user.build_client_datum(cpf: "02241335002")
    user.save!
    login_as(user)

    post buffet_registrations_path, params: {"buffet_registration" => {"maximum_quantity" => "30"}}

    expect(response).to redirect_to(root_path)
  end


end