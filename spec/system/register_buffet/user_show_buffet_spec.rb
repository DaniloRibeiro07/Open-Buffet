require 'rails_helper'

describe 'Usuário clica em vê buffet' do 
  it "E vê os dados do buffet" do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Vê"

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
    expect(page).to have_button "Editar"
    expect(page).to have_button "Voltar"
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
    click_on "Vê"

    click_on "Voltar"

    expect(current_path).to eq root_path
  end

  it "E clica em Editar" do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Vê"

    click_on "Editar"

    expect(current_path).to eq edit_buffet_registration_path(buffet_registration.id)
  end
end