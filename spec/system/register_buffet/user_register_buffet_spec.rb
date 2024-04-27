require 'rails_helper'

describe 'Usuario Empresa acessa cadastro Buffet' do 
  it 'E vê a tela de cadastro' do 
    user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
    login_as user
    visit root_path

    expect(current_path).to eq new_buffet_registration_path
    expect(page).to have_field "Nome Fantasia"
    expect(page).to have_field "Razão Social"
    expect(page).to have_field "CNPJ"
    expect(page).to have_field "Telefone"
    expect(page).to have_field "E-mail"
    expect(page).to have_field "Logradouro"
    expect(page).to have_field "N°"
    expect(page).to have_field "Bairro"
    expect(page).to have_field "Estado"
    expect(page).to have_field "Cidade"
    expect(page).to have_field "CEP"
    expect(page).to have_field "Complemento"
    expect(page).to have_field "Descrição do Buffet"
    expect(page).to have_content "Escolha as Formas de Pagamento Aceitas:"
    expect(page).to have_content "PIX" 
    expect(page).to have_content "Boleto" 
    expect(page).to have_content "Cartão de Crédito" 
    expect(page).to have_content "Cartão de Débito" 
    expect(page).to have_content "Dinheiro" 
    expect(page).to have_content "Bitcoin" 
    expect(page).to have_content "Transferência Bancária" 
    expect(page).to have_button "Salvar"
  end

  it 'E Cadastra com sucesso' do 
    user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
    login_as user
    visit root_path

    fill_in "Nome Fantasia",	with: "Buffet da familia"
    fill_in "Razão Social",	with: 'Eduarda Buffet'  
    fill_in "CNPJ", with: '95687495213'
    fill_in "Telefone", with: '7995876812'
    fill_in 'E-mail', with: 'Eduarda@teste.com'
    fill_in 'Logradouro', with: 'Rua das flores'
    fill_in 'N°', with: 'Rua das flores'
    fill_in 'Bairro', with: 'João Alves'
    fill_in 'Estado', with: 'São Paulo'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'CEP', with: '49058-600'
    fill_in 'Complemento', with: 'João Alves'
    fill_in "Descrição do Buffet", with: 'Melhor buffet da região'
    check "PIX"
    check "Cartão de Débito"
    check "Cartão de Crédito"
    check "Dinheiro"

    click_on "Salvar"

    expect(current_path).to eq root_path
    expect(page).to have_content "Buffet Cadastrado com Sucesso" 
  end

  it 'E Esquece de preencher os campos' do 
    user = User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: true)
    
    login_as user

    visit root_path

    click_on "Salvar"

    expect(page).to have_content "erros encontrados"
    expect(page).to have_content "Nome Fantasia não pode ficar em branco"
    expect(page).to have_content "Razão Social não pode ficar em branco" 
    expect(page).to have_content "Telefone não pode ficar em branco" 
    expect(page).to have_content "CNPJ não pode ficar em branco" 
    expect(page).to have_content "Logradouro não pode ficar em branco" 
    expect(page).to have_content "E-mail não pode ficar em branco" 
    expect(page).to have_content "N° não pode ficar em branco" 
    expect(page).to have_content "Bairro não pode ficar em branco" 
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "CEP não pode ficar em branco"
    expect(page).to have_content "Descrição do Buffet não pode ficar em branco" 
    expect(page).to have_content "Um método de pagamento deve ser escolhido" 
  end
end