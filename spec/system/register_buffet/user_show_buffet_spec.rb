require 'rails_helper'

describe 'Usuário clica em vê buffet' do 
  it "E vê os dados do buffet sendo o dono do buffet com eventos cadastrados" do 
    other_user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    other_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: other_user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    other_event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: other_buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: other_user)
    
  
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
      minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Formatura", description: "Formatura insana para universitários",
      minimum_quantity: 50, maximum_quantity: 200, duration: 180, menu: "Salgados, Crustáceos, Tortas, e o que os universitários quiser", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"

    expect(page).not_to have_content "Buffet da Avon"
    expect(page).to have_content "Nome Fantasia: Buffet da familia"
    expect(page).to have_content 'Razão Social: Eduarda Buffet'
    expect(page).to have_content "CNPJ: 95687495213"
    expect(page).to have_content "Telefone: 7995876812"
    expect(page).to have_content "E-mail: Eduarda@teste.com"
    expect(page).to have_content "Logradouro: Rua das flores"
    expect(page).to have_content "N°: 25A"
    expect(page).to have_content "Bairro: São Lucas"
    expect(page).to have_content "Estado: SP"
    expect(page).to have_content "Cidade: São Paulo"
    expect(page).to have_content "Complemento: "
    expect(page).to have_content "CEP: 48750-621"
    expect(page).to have_content "Descrição: O melhor buffet da familia brasileira"
    expect(page).to have_content "Formas de pagamento aceitas:"
    expect(page).to have_content "PIX"
    expect(page).to have_content "Transferência Bancária"
    expect(page).to have_content "Dinheiro"     
    expect(page).to have_content "Bitcoin" 
    expect(page).to have_link "Casamento" 
    expect(page).to have_link "Formatura" 
    expect(page).not_to have_content "Aniversário"
    expect(page).not_to have_content "Nenhum evento cadastrado"    
    expect(page).to have_button "Editar"
    expect(page).to have_button "Voltar"
    expect(page).to have_link "Adicionar"
  end

  it "E vê os dados do buffet sendo o dono do buffet sem eventos" do 
    other_user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    other_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: other_user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    other_event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: other_buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: other_user)

    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"

    expect(page).to have_content "Nenhum evento cadastrado"    
    expect(page).to have_button "Editar"
    expect(page).to have_button "Voltar"
    expect(page).to have_link "Adicionar"
  end

  it "E clica em Editar sendo o Dono do Buffet" do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"

    click_on "Editar"

    expect(current_path).to eq edit_buffet_registration_path(buffet_registration.id)
  end

  it "E clica em voltar" do 
    
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"

    click_on "Voltar"

    expect(current_path).to eq root_path
  end

  it "E vê os dados do buffet sendo visitante com eventos cadastrados" do 
    other_user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    other_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: other_user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    other_event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: other_buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: other_user)
    
  
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
      minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Formatura", description: "Formatura insana para universitários",
      minimum_quantity: 50, maximum_quantity: 200, duration: 180, menu: "Salgados, Crustáceos, Tortas, e o que os universitários quiser", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

    visit root_path
    click_on "Buffet da familia"

    expect(page).not_to have_content "Buffet da Avon"
    expect(page).to have_content "Nome Fantasia: Buffet da familia"
    expect(page).not_to have_content 'Razão Social: Eduarda Buffet'
    expect(page).to have_content "CNPJ: 95687495213"
    expect(page).to have_content "Telefone: 7995876812"
    expect(page).to have_content "E-mail: Eduarda@teste.com"
    expect(page).to have_content "Logradouro: Rua das flores"
    expect(page).to have_content "N°: 25A"
    expect(page).to have_content "Bairro: São Lucas"
    expect(page).to have_content "Estado: SP"
    expect(page).to have_content "Cidade: São Paulo"
    expect(page).to have_content "Complemento: "
    expect(page).to have_content "CEP: 48750-621"
    expect(page).to have_content "Descrição: O melhor buffet da familia brasileira"
    expect(page).to have_content "Formas de pagamento aceitas:"
    expect(page).to have_content "PIX"
    expect(page).to have_content "Transferência Bancária"
    expect(page).to have_content "Dinheiro"     
    expect(page).to have_content "Bitcoin" 
    expect(page).to have_link "Casamento" 
    expect(page).to have_link "Formatura" 
    expect(page).not_to have_content "Aniversário"
    expect(page).not_to have_content "Nenhum evento cadastrado"    
    expect(page).not_to have_button "Editar"
    expect(page).to have_button "Voltar"
    expect(page).not_to have_link "Adicionar"
  end

  it "E vê os dados do buffet sendo visitante sem eventos cadastrados" do 
    other_user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    other_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: other_user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    other_event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: other_buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: other_user)
    
  
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    visit root_path
    click_on "Buffet da familia"
  
    expect(page).to have_content "Nenhum evento cadastrado"
  end

  it "E vê os dados do buffet sendo cliente" do 
    other_user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    other_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: other_user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    other_event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: other_buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: other_user)
    
  
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
      minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Formatura", description: "Formatura insana para universitários",
      minimum_quantity: 50, maximum_quantity: 200, duration: 180, menu: "Salgados, Crustáceos, Tortas, e o que os universitários quiser", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

    client = User.create!(name: "Marta", last_name: "Almeida", email: 'Almeida@teste.com', password: 'teste123', company: false)

    login_as client

    visit root_path
    click_on "Buffet da familia"

    expect(page).not_to have_content "Buffet da Avon"
    expect(page).to have_content "Nome Fantasia: Buffet da familia"
    expect(page).not_to have_content 'Razão Social: Eduarda Buffet'
    expect(page).to have_content "CNPJ: 95687495213"
    expect(page).to have_content "Telefone: 7995876812"
    expect(page).to have_content "E-mail: Eduarda@teste.com"
    expect(page).to have_content "Logradouro: Rua das flores"
    expect(page).to have_content "N°: 25A"
    expect(page).to have_content "Bairro: São Lucas"
    expect(page).to have_content "Estado: SP"
    expect(page).to have_content "Cidade: São Paulo"
    expect(page).to have_content "Complemento: "
    expect(page).to have_content "CEP: 48750-621"
    expect(page).to have_content "Descrição: O melhor buffet da familia brasileira"
    expect(page).to have_content "Formas de pagamento aceitas:"
    expect(page).to have_content "PIX"
    expect(page).to have_content "Transferência Bancária"
    expect(page).to have_content "Dinheiro"     
    expect(page).to have_content "Bitcoin" 
    expect(page).to have_link "Casamento" 
    expect(page).to have_link "Formatura" 
    expect(page).not_to have_content "Aniversário"
    expect(page).not_to have_content "Nenhum evento cadastrado"    
    expect(page).not_to have_button "Editar"
    expect(page).to have_button "Voltar"
    expect(page).not_to have_link "Adicionar"
  end

  it "E vê os dados do buffet sendo cliente" do 
    other_user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    other_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: other_user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    other_event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: other_buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: other_user)
    
  
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    visit root_path
    click_on "Buffet da familia"
  
    expect(page).to have_content "Nenhum evento cadastrado"
  end

  it "E vê os dados do buffet sendo visitante dono de outro buffet" do 
    other_user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    other_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: other_user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    other_event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: other_buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: other_user)
    
  
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
      minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Formatura", description: "Formatura insana para universitários",
      minimum_quantity: 50, maximum_quantity: 200, duration: 180, menu: "Salgados, Crustáceos, Tortas, e o que os universitários quiser", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

    login_as other_user
    visit root_path
    click_on "Buffet da familia"

    expect(page).not_to have_content "Buffet da Avon"
    expect(page).to have_content "Nome Fantasia: Buffet da familia"
    expect(page).not_to have_content 'Razão Social: Eduarda Buffet'
    expect(page).to have_content "CNPJ: 95687495213"
    expect(page).to have_content "Telefone: 7995876812"
    expect(page).to have_content "E-mail: Eduarda@teste.com"
    expect(page).to have_content "Logradouro: Rua das flores"
    expect(page).to have_content "N°: 25A"
    expect(page).to have_content "Bairro: São Lucas"
    expect(page).to have_content "Estado: SP"
    expect(page).to have_content "Cidade: São Paulo"
    expect(page).to have_content "Complemento: "
    expect(page).to have_content "CEP: 48750-621"
    expect(page).to have_content "Descrição: O melhor buffet da familia brasileira"
    expect(page).to have_content "Formas de pagamento aceitas:"
    expect(page).to have_content "PIX"
    expect(page).to have_content "Transferência Bancária"
    expect(page).to have_content "Dinheiro"     
    expect(page).to have_content "Bitcoin" 
    expect(page).to have_link "Casamento" 
    expect(page).to have_link "Formatura" 
    expect(page).not_to have_content "Aniversário"
    expect(page).not_to have_content "Nenhum evento cadastrado"    
    expect(page).not_to have_button "Editar"
    expect(page).to have_button "Voltar"
    expect(page).not_to have_link "Adicionar"
  end

  it "E vê os dados do buffet sendo visitante sem eventos cadastrados" do 
    other_user = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    other_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
        cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
        state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
        payment_method: payment_method, user: other_user)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 50)

    other_event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
        buffet_registration: other_buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
        minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
        alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: other_user)
    
  
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as other_user

    visit root_path
    click_on "Buffet da familia"
  
    expect(page).to have_content "Nenhum evento cadastrado"
  end

end