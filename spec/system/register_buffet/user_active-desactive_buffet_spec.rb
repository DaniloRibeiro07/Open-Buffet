require 'rails_helper'

describe 'Dono do buffet acessa a página de visualização do seu buffet' do
   
  it 'e desativa o seu buffet' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Desativar Buffet"

    expect(current_path).to eq buffet_registration_path(buffet_registration)
    expect(page).to have_content "Buffet Desativado com sucesso"
    expect(page).to have_content "Status: Desativado"
    expect(page).to have_button "Ativar Buffet"
  end

  it 'e ativa o seu buffet' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user, available: :desactive)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Ativar Buffet"

    expect(current_path).to eq buffet_registration_path(buffet_registration)
    expect(page).to have_content "Buffet Ativado com sucesso"
    expect(page).to have_content "Status: Ativado"
    expect(page).to have_button "Desativar Buffet"
  end

end

describe 'Dono do buffet acessa a página de edição do seu buffet' do
   
  it 'e desativa o seu buffet' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Editar Informações do Buffet"
    click_on "Desativar Buffet"

    expect(current_path).to eq buffet_registration_path(buffet_registration)
    expect(page).to have_content "Buffet Desativado com sucesso"
    expect(page).to have_content "Status: Desativado"
    expect(page).to have_button "Ativar Buffet"
  end

  it 'e ativa o seu buffet' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user, available: :desactive)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Editar Informações do Buffet"
    click_on "Ativar Buffet"

    expect(current_path).to eq buffet_registration_path(buffet_registration)
    expect(page).to have_content "Buffet Ativado com sucesso"
    expect(page).to have_content "Status: Ativado"
    expect(page).to have_button "Desativar Buffet"
  end

end