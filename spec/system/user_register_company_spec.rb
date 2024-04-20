require 'rails_helper'

describe 'Usuário acessa a página de criar conta' do 
  it 'e vê a página' do 
    visit root_path 
    click_on "Entrar/Registrar"
    click_on "Crie a sua conta"

    expect(current_path).to eq new_user_registration_path
    expect(page).to have_field "Nome" 
    expect(page).to have_field "Sobrenome" 
    expect(page).to have_field "E-mail"
    expect(page).to have_field "Senha"
    expect(page).to have_field "Confirme sua senha"
    expect(page).to have_content "Conta Empresa"
    expect(page).to have_content "Conta Cliente" 
    expect(page).to have_button "Criar Conta" 
  end

  it 'Cria uma conta cliente com sucesso' do 
    visit root_path 
    click_on "Entrar/Registrar"
    click_on "Crie a sua conta"
    fill_in "Nome",	with: "Maria" 
    fill_in "Sobrenome",	with: "Almeida"
    fill_in "E-mail",	with: "maria@almeida.com" 
    fill_in "Senha",	with: "123456" 
    fill_in "Confirme sua senha",	with: "123456" 
    choose "Conta Cliente" 
    click_on "Criar Conta"

    user = User.last
    expect(user.name).to eq "Maria"
    expect(user.last_name).to eq "Almeida"
    expect(user.company).to eq false
    expect(user.email).to eq "maria@almeida.com"
    
    expect(current_path).to eq root_path 
    expect(page).to have_content "Bem vindo! Você realizou seu registro com sucesso."
    expect(page).to have_content "Maria |Conta Cliente|" 
    expect(page).not_to have_content "Entrar/Registrar"
  end

  it 'Cria uma conta empresa com sucesso' do 
    visit root_path 
    click_on "Entrar/Registrar"
    click_on "Crie a sua conta"
    fill_in "Nome",	with: "Lucas" 
    fill_in "Sobrenome",	with: "Almeida"
    fill_in "E-mail",	with: "lucas@almeida.com" 
    fill_in "Senha",	with: "123456" 
    fill_in "Confirme sua senha",	with: "123456" 
    choose "Conta Empresa" 
    click_on "Criar Conta"

    user = User.last
    expect(user.name).to eq "Lucas"
    expect(user.last_name).to eq "Almeida"
    expect(user.company).to eq true
    expect(user.email).to eq "lucas@almeida.com"
    
    expect(current_path).to eq root_path 
    expect(page).to have_content "Bem vindo! Você realizou seu registro com sucesso."
    expect(page).to have_content "Lucas |Conta Empresa|" 
    expect(page).not_to have_content "Entrar/Registrar"
  end

end