require 'rails_helper'

describe 'Usuário clica em editar buffet' do 
  it "E vê os dados do buffet" do 
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


    expect(page).to have_field "Nome Fantasia", with: "Buffet da familia"
    expect(page).to have_field "Razão Social", with: "Eduarda Buffet"
    expect(page).to have_field "CNPJ", with: "95687495213"
    expect(page).to have_field "Telefone", with: "7995876812"
    expect(page).to have_field "E-mail", with: "Eduarda@teste.com"
    expect(page).to have_field "Logradouro", with: "Rua das flores"
    expect(page).to have_field "N°", with: "25A"
    expect(page).to have_field "Bairro", with: "São Lucas"
    expect(page).to have_field "Estado", with: "SP"
    expect(page).to have_field "Cidade", with: "São Paulo"
    expect(page).to have_field "Complemento", with: ""
    expect(page).to have_field "CEP", with: "48750-621"
    expect(page).to have_field "Descrição", with: "O melhor buffet da familia brasileira"
    expect(page).to have_content "Escolha as Formas de Pagamento Aceitas:"
    expect(page).to have_checked_field "PIX"
    expect(page).to have_checked_field "Transferência Bancária"
    expect(page).to have_checked_field "Dinheiro"     
    expect(page).to have_checked_field "Bitcoin"     
    expect(page).to have_button "Salvar"
    expect(page).to have_button "Voltar"
    expect(page).to have_unchecked_field "Boleto" 
    expect(page).to have_unchecked_field "Cartão de Crédito" 
    expect(page).to have_unchecked_field "Cartão de Débito" 
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
    click_on "Editar"
    click_on "Voltar"

    expect(current_path).to eq buffet_registration_path(buffet_registration.id)
  end

  it "E edita em Telefone, Email e Descrição e formas de pagamento" do 
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

    fill_in "Telefone",	with: "7895436125"
    fill_in "E-mail",	with: "testando@email.com"
    fill_in "Descrição",	with: "O melhor dos melhores buffet" 
    check "Cartão de Débito"
    check "Cartão de Crédito"
    uncheck "Dinheiro"

    click_on "Salvar"
    

    expect(current_path).to eq buffet_registration_path(buffet_registration.id)
    expect(page).to have_content "Nome Fantasia: Buffet da familia"
    expect(page).to have_content 'Razão Social: Eduarda Buffet'
    expect(page).to have_content "CNPJ: 95687495213"
    expect(page).to have_content "Telefone: 7895436125"
    expect(page).to have_content "E-mail: testando@email.com"
    expect(page).to have_content "Logradouro: Rua das flores"
    expect(page).to have_content "N°: 25A"
    expect(page).to have_content "Bairro: São Lucas"
    expect(page).to have_content "Estado: SP"
    expect(page).to have_content "Cidade: São Paulo"
    expect(page).to have_content "Complemento: "
    expect(page).to have_content "CEP: 48750-621"
    expect(page).to have_content "Descrição: O melhor dos melhores buffet" 
    expect(page).to have_content "Formas de pagamento aceitas:"
    expect(page).to have_content "PIX"
    expect(page).to have_content "Transferência Bancária"
    expect(page).to have_content "Cartão de Débito"
    expect(page).to have_content "Cartão de Crédito"
    expect(page).not_to have_content "Dinheiro"     
    expect(page).to have_content "Bitcoin"     
    expect(page).to have_button "Editar"
    expect(page).to have_button "Voltar"
  end

  it "E deixa alguns campos obrigatórios vazios" do 
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

    fill_in "Telefone",	with: "7895436125"
    fill_in "E-mail",	with: ""
    fill_in "Descrição",	with: "O melhor dos melhores buffet" 
    check "Cartão de Débito"
    check "Cartão de Crédito"
    uncheck "Dinheiro"

    click_on "Salvar"
    
    expect(page).to have_content "E-mail não pode ficar em branco"
    expect(page).to have_unchecked_field "Dinheiro"
    expect(page).to have_checked_field "Cartão de Crédito"
    expect(page).to have_checked_field "Cartão de Débito"
    expect(page).to have_field('Telefone', with: "7895436125")
    expect(page).to have_field('Descrição', with: "O melhor dos melhores buffet")


  end


end