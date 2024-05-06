require 'rails_helper'


describe "Usuário acessa a página que espera a sua avaliação para confirmação" do 
  it 'E confirma o Pedido dentro do prazo de confirmação' do 
    user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
    payment_method = PaymentMethod.create!(pix: true, boleto:true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
      neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

    event_value = EventValue.create!(base_price: 50, price_per_person: 30, overtime_rate: 30)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
      minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

    cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
    cliente.build_client_datum(cpf: "97498970058")
    cliente.save!

    extra_service = ExtraService.new(decoration: true)
    order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                          amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
            final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")
    order.waiting_for_client_review!

    login_as cliente
    visit root_path
    click_on "Meus pedidos"
    click_on order.code
    click_on "Confirmar Pedido"
    
    expect(page).to have_content "Pedido Confirmado"
    expect(page).to have_content "Status do Pedido: Aprovado"
  end

  it 'E tenta confirmar o pedido, mas ele está fora do prazo e é cancelado' do 
    user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
    payment_method = PaymentMethod.create!(pix: true, boleto:true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
      neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

    event_value = EventValue.create!(base_price: 50, price_per_person: 30, overtime_rate: 30)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
      minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

    cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
    cliente.build_client_datum(cpf: "97498970058")
    cliente.save!

    extra_service = ExtraService.new(decoration: true)
    order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                          amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
            final_value: 55, justification_final_value: "Imposto", expiration_date: Date.current , payment_method: "pix")
    order.waiting_for_client_review!

    login_as cliente
    visit root_path
    click_on "Meus pedidos"
    click_on order.code
    click_on "Confirmar Pedido"
    
    expect(page).to have_content "Pedido vencido, pedido cancelado"
    expect(page).to have_content "Status do Pedido: Cancelado"
  end
end