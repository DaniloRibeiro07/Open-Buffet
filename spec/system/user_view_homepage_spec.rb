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

end