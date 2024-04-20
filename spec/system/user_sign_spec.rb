require 'rails_helper'

describe 'Usuário acessa a página de registro' do 
  it 'E vê a página' do 
    visit root_path

    within('nav') do
      click_on 'Entrar/Registrar'
    end

    expect(current_path).to eq new_user_session_path
    expect(page).to have_field("E-mail") 
    expect(page).to have_field("Senha") 
    expect(page).to have_button("Entrar") 
    expect(page).to have_link("Crie a sua conta") 
    expect(page).to have_link("Esqueceu a senha ?") 
  end

  it 'E faz login como usuario buffet' do 
    User.create!(name: "Maria", last_name: "Souza", email: 'maria@teste.com', password: 'teste123', company: true)

    visit root_path
    click_on 'Entrar/Registrar'
    fill_in "E-mail",	with: 'maria@teste.com'
    fill_in "Senha",	with: "teste123" 
    click_on "Entrar"

    expect(page).to have_content "Login efetuado com sucesso." 
    expect(page).not_to have_content  'Entrar/Registrar'
    expect(page).to have_content "Maria |Conta Empresa|" 
    expect(page).to have_button "Sair" 
    expect(current_path).to eq root_path 
  end

  it 'E faz login como usuário cliente' do 
    User.create!(name: "Eduarda", last_name: "Farias", email: 'Eduarda@teste.com', password: 'teste123', company: false)

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