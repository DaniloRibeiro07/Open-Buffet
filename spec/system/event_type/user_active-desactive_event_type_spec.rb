require 'rails_helper'

describe "Dono do buffet acessa detalhes do tipo de evento" do

  it 'e Desativa um Evento Habilitado' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)

    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working, buffet_registration: buffet_registration, 
      name: "Aniversário", description: "Super aniversário para a sua familia e amigos", minimum_quantity: 10, maximum_quantity: 15, 
      duration: 60, menu: "Bolo de aniversário, coxinha e salgados", alcoholic_beverages: false, decoration: true, valet: true, 
      insider: false, outsider: true, user: user)

    login_as user

    visit root_path

    click_on 'Meu Buffet'
    click_on 'Aniversário'
    click_on 'Desativar Evento'

    expect(current_path).to eq event_type_path(event)
    expect(page).to have_content "Evento Desativado com Sucesso"
    expect(page).to have_button "Ativar Evento"
    expect(page).to have_content "Status do Evento: Desativado"
  end

  it 'e Ativa um Evento Desabilitado' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)

    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working, buffet_registration: buffet_registration, 
      name: "Aniversário", description: "Super aniversário para a sua familia e amigos", minimum_quantity: 10, maximum_quantity: 15, 
      duration: 60, menu: "Bolo de aniversário, coxinha e salgados", alcoholic_beverages: false, decoration: true, valet: true, 
      insider: false, outsider: true, user: user, status: :desactive)

    login_as user

    visit root_path

    click_on 'Meu Buffet'
    click_on 'Aniversário'
    click_on 'Ativar Evento'

    expect(current_path).to eq event_type_path(event)
    expect(page).to have_content "Evento Ativado com Sucesso"
    expect(page).to have_button "Desativar Evento"
    expect(page).to have_content "Status do Evento: Ativado"
  end

end
