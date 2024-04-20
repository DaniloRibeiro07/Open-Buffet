require 'rails_helper'

describe 'Usuário acessa a página inicial' do 

  it 'Vê a tela inicial' do 
    visit root_path

    expect(page).to have_link("Entrar/Registrar")
  end

end