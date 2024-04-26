require 'rails_helper'

describe 'Usuário acessa a página inicial' do 

  it 'Vê a tela inicial' do 
    visit root_path

    expect(page).to have_link("Entrar/Registrar")
  end

  it 'Sendo uma empresa com buffet' do
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path

    expect(current_path).to eq root_path 
    expect(page).to have_content "Buffet da familia"
    expect(page).to have_content "CNPJ: 95687495213" 
    expect(page).to have_content "Telefone: 7995876812"
    expect(page).to have_content "Endereço: Rua das flores, 25A, 48750-621, São Paulo-SP"
    expect(page).to have_button "Vê" 
    expect(page).to have_content "Nenhum evento cadastrado" 
    expect(page).to have_link "Adicionar" 
  end

  it 'Sendo um visitante não autorizado' do 
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

    visit root_path
    expect(page).to have_link "Buffet da familia", href: buffet_registration_path(buffet_registration.id)
    expect(page).to have_content "Cidade: São Paulo"
    expect(page).to have_content "Estado: SP"
    expect(page).to have_link "Buffet Astrônomo", href: buffet_registration_path(buffet_registration2.id)
    expect(page).to have_content "Cidade: Salvador"
    expect(page).to have_content "Estado: BA"
  end

  it 'Sendo um visitante não autorizado clica no segundo buffet' do 
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

    visit root_path
    
    click_on "Buffet Astrônomo"

    expect(current_path).to eq buffet_registration_path(buffet_registration2.id)
  end

end