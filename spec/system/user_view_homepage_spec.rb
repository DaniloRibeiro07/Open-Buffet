require 'rails_helper'

describe 'Usuário acessa a página inicial' do 

  it 'Vê a tela inicial e não há buffet cadastrado' do 
    visit root_path
    
    expect(page).to have_button "Pesquisar"
    expect(page).to have_content("Não há Buffets Cadastrados")  
    expect(page).to have_link("Entrar/Registrar")
    expect(page).not_to have_content("Sair")   
    expect(page).not_to have_content("Meus pedidos")   
    expect(page).not_to have_content("Pedidos")   
  end

  it 'Sendo uma empresa sem buffet' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    login_as user

    visit root_path

    expect(current_path).to eq new_buffet_registration_path 
  end 

  it 'Sendo uma empresa com buffet' do
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    user2 = User.create!(name: "Antônia", last_name: "Fernanda", email: 'Antônia@teste.com', password: 'teste123', company: true)
    buffet_registration2 = BuffetRegistration.create!(trading_name: 'Buffet Astrônomo', company_name: 'Fernanda Buffet', 
        cnpj: "568498723", phone: "715863246", email: 'fernada@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
        state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet dos ares", 
        payment_method: payment_method, user: user2)
  
    login_as user

    visit root_path

    expect(page).to have_link "Meu Buffet", href: buffet_registration_path(buffet_registration) 
    expect(page).to have_content "2 Buffet Cadastrados"
    expect(page).not_to have_content("Meus pedidos")
    expect(page).to have_content("Pedidos")
    expect(current_path).to eq root_path
    within('div#95687495213') do
      expect(page).to have_link "Detalhes", href: buffet_registration_path(buffet_registration)
      expect(page).to have_content "Cidade/Estado: São Paulo/SP"
    end

    within('div#568498723') do
      expect(page).to have_link "Detalhes", href: buffet_registration_path(buffet_registration2)
      expect(page).to have_content "Cidade/Estado: Salvador/BA"
    end
  end

  it 'Sendo um visitante não autenticado' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    user2 = User.create!(name: "Antônia", last_name: "Fernanda", email: 'Antônia@teste.com', password: 'teste123', company: true)
    buffet_registration2 = BuffetRegistration.create!(trading_name: 'Buffet Astrônomo', company_name: 'Fernanda Buffet', 
      cnpj: "568498723", phone: "715863246", email: 'fernada@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
      state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet dos ares", 
      payment_method: payment_method, user: user2)

    user3 = User.create!(name: "Jooj", last_name: "Fernando", email: 'Jooj@teste.com', password: 'teste123', company: true)
    disable_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet Desativado', company_name: 'Fernanda Buffet', 
      cnpj: "568298723", phone: "715863246", email: 'fernada@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
      state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet desativado", 
      payment_method: payment_method, user: user3, available: :desactive)
  

    visit root_path
    within('div#95687495213') do
      expect(page).to have_link "Detalhes", href: buffet_registration_path(buffet_registration)
      expect(page).to have_content "Cidade/Estado: São Paulo/SP"
    end
    within('div#568498723') do
      expect(page).to have_link "Detalhes", href: buffet_registration_path(buffet_registration2)
      expect(page).to have_content "Cidade/Estado: Salvador/BA"
    end
    expect(page).not_to have_link "Buffet Desativado"

  end

  it 'Sendo um visitante não autenticado, clica no segundo buffet' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    user2 = User.create!(name: "Antônia", last_name: "Fernanda", email: 'Antônia@teste.com', password: 'teste123', company: true)
    buffet_registration2 = BuffetRegistration.create!(trading_name: 'Buffet Astrônomo', company_name: 'Fernanda Buffet', 
      cnpj: "568498723", phone: "715863246", email: 'fernada@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
      state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet dos ares", 
      payment_method: payment_method, user: user2)

    visit root_path
    
    within('div#568498723') do
      click_on "Detalhes"
    end

    expect(current_path).to eq buffet_registration_path(buffet_registration2.id)
  end

  it 'Sendo um visitante autenticado' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    user2 = User.create!(name: "Antônia", last_name: "Fernanda", email: 'Antônia@teste.com', password: 'teste123', company: true)
    buffet_registration2 = BuffetRegistration.create!(trading_name: 'Buffet Astrônomo', company_name: 'Fernanda Buffet', 
      cnpj: "568498723", phone: "715863246", email: 'fernada@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
      state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet dos ares", 
      payment_method: payment_method, user: user2)

    user3 = User.create!(name: "Jooj", last_name: "Fernando", email: 'Jooj@teste.com', password: 'teste123', company: true)
    disable_buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet Desativado', company_name: 'Fernanda Buffet', 
      cnpj: "568298723", phone: "715863246", email: 'fernada@teste.com', public_place: "Rua das Igrejas", address_number: "66A", neighborhood: "São Miguel", 
      state: "BA", city: "Salvador", zip: "45860-621", complement: "", description: "O Buffet desativado", 
      payment_method: payment_method, user: user3, available: :desactive)

    visitante = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
    visitante.build_client_datum(cpf: "97498970058")
    visitante.save!

    login_as visitante

    visit root_path
    within('div#95687495213') do
      expect(page).to have_link "Detalhes", href: buffet_registration_path(buffet_registration)
    end
    within('div#568498723') do
      expect(page).to have_link "Detalhes", href: buffet_registration_path(buffet_registration2)
    end
    expect(page).to have_content("Meus pedidos")
    expect(page).not_to have_content("Pedidos")
  end


end