require 'rails_helper'

describe "Usuário dono de um buffet clica em adicionar evento" do 
  it 'Vê a tela de registro' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Adicionar"

    expect(current_path).to eq new_event_type_path
    expect(page).to have_field "Nome do Evento"
    expect(page).to have_field "Descrição do Evento"
    expect(page).to have_field "Quantidade Mínima de Pessoas"
    expect(page).to have_field "Quantidade Máxima de Pessoas"
    expect(page).to have_field "Duração"
    expect(page).to have_field "Cardápio"
    expect(page).to have_field "Bebida Alcoólica"
    expect(page).to have_field "Decoração"
    expect(page).to have_field "Serviço de Estacionamento/Valet"
    expect(page).to have_field "Evento dentro do Buffet"
    expect(page).to have_field "Evento à domicílio"
    expect(page).to have_field "Preço Base"
    expect(page).to have_field "Preço por Acréscimo de Pessoa"
    expect(page).to have_field "Valor da hora extra"
    expect(page).to have_field "Valor Diferente aos Finais de Semana"
    expect(page).to have_button "Salvar" 
    expect(page).to have_button "Voltar" 
  end

  it 'Cadastra com sucesso' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Adicionar"

    fill_in "Nome do Evento",	with: "Festa de Aniversário" 
    fill_in "Descrição do Evento",	with: "Festa de Aniversário para familia e amigos"
    fill_in "Quantidade Mínima de Pessoas",	with: "10"
    fill_in "Quantidade Máxima de Pessoas",	with: "55"
    fill_in "Duração em minutos",	with: "60"
    fill_in "Cardápio",	with: "Bolo, coxinha, torta, cachorro quente" 
    check "Evento à domicílio"
    check "Bebida Alcoólica"
    fill_in "Preço Base", with: "10000.50"
    fill_in "Preço por Acréscimo de Pessoa", with: "500.35"
    fill_in "Valor da hora extra", with: "405.93"

    click_on "Salvar"

    expect(current_path).to eq event_type_path(EventType.last.id) 
  end

  it 'Usuário esqueceu dos campos' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Adicionar"

    click_on "Salvar"

    expect(page).to have_content "erros encontrados"
    expect(page).to have_content "Nome do Evento não pode ficar em branco"
    expect(page).to have_content "Descrição do Evento não pode ficar em branco"
    expect(page).to have_content "Quantidade Mínima de Pessoas não pode ficar em branco"
    expect(page).to have_content "Quantidade Máxima de Pessoas não pode ficar em branco"
    expect(page).to have_content "Duração em minutos não pode ficar em branco"
    expect(page).to have_content "Cardápio não pode ficar em branco"
    expect(page).to have_content "Quantidade Máxima de Pessoas não pode ficar em branco"
    expect(page).to have_content "O local onde o serviço pode ser ofertado deve ser marcado"
  end
end