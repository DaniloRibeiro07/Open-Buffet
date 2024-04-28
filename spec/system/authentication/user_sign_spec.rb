require 'rails_helper'

describe 'Usuário acessa a página de registro' do 
  it 'E vê a página' do 
    visit root_path

    within('nav') do
      click_on 'Entrar/Registrar'
    end
    
    expect(page).not_to have_button "Pesquisar"
    expect(current_path).to eq new_user_session_path
    expect(page).to have_field("E-mail") 
    expect(page).to have_field("Senha") 
    expect(page).to have_button("Entrar") 
    expect(page).to have_link("Crie a sua conta") 
    expect(page).to have_link("Esqueceu a senha ?") 
  end

  it 'E faz login como conta empresa sem buffet' do 
    User.create!(name: "Maria", last_name: "Souza", email: 'maria@teste.com', password: 'teste123', company: true)

    visit root_path
    click_on 'Entrar/Registrar'
    fill_in "E-mail",	with: 'maria@teste.com'
    fill_in "Senha",	with: "teste123" 
    click_on "Entrar"

    expect(page).not_to have_content  'Entrar/Registrar'
    expect(page).to have_content "Maria |Conta Empresa|" 
    expect(page).to have_button "Sair" 
    expect(current_path).to eq new_buffet_registration_path 
  end

  it 'E faz login como conta empresa com buffet' do 
    user = User.create!(name: "Maria", last_name: "Souza", email: 'maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
    cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
    state: "São Paulo", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
    payment_method: payment_method, user: user)

    visit root_path
    click_on 'Entrar/Registrar'
    fill_in "E-mail",	with: 'maria@teste.com'
    fill_in "Senha",	with: "teste123" 
    click_on "Entrar"

    expect(page).to have_content 'Login efetuado com sucesso' 
    expect(page).not_to have_content  'Entrar/Registrar'
    expect(page).to have_content "Maria |Conta Empresa|" 
    expect(page).to have_button "Sair" 
    expect(current_path).to eq root_path 
  end

  it 'E faz login como usuário cliente' do 
    user = User.new(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: false)
    user.build_client_datum(cpf: "02241335002")
    user.save!

    visit root_path
    click_on 'Entrar/Registrar'
    fill_in "E-mail",	with: 'Eduarda@teste.com'
    fill_in "Senha",	with: "teste123" 
    click_on "Entrar"

    expect(page).to have_content "Login efetuado com sucesso." 
    expect(page).not_to have_content  'Entrar/Registrar'
    expect(page).to have_content "Eduarda |Conta Cliente|" 
    expect(page).to have_button "Sair" 
    expect(current_path).to eq root_path 
  end
end