require 'rails_helper'

describe "Usuárioa acessa a página de detalhes do evento" do
  it 'Vê a página' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    event = EventType.create!(buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
      minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
      alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)

    login_as user

    visit root_path
    click_on "Aniversário"

    expect(page).to have_content "Evento associado ao Buffet: Buffet da familia" 
    expect(page).to have_content "Nome do Evento: Aniversário" 
    expect(page).to have_content "Descrição do Evento: Super aniversário para a sua familia e amigos" 
    expect(page).to have_content "Quantidade Mínima de participantes: 10" 
    expect(page).to have_content "Quantidade Máxima de participantes: 15"  
    expect(page).to have_content "Duração do evento em minutos: 60" 
    expect(page).to have_content "Cardápio: Bolo de aniversário, coxinha e salgados"
    expect(page).to have_content "O Evento pode conter bebidas alcoólicas: Não" 
    expect(page).to have_content "O Evento pode conter Decorações: Sim" 
    expect(page).to have_content "O Evento pode conter serviço de estacionamento/valet: Sim" 
    expect(page).to have_content "O evento pode ser dentro do buffet: Não" 
    expect(page).to have_content "O evento pode ser à domicilio: Sim" 
    expect(page).to have_content "Editar Informações do Evento"
    expect(page).to have_button "Voltar" 
  end
end