require 'rails_helper'

describe 'Dono do buffet acessa a pagína de visualização do buffet que espera a sua avaliação' do 
  it 'e cadastra o valor final com sucesso com justificativa' do 
    user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
    payment_method = PaymentMethod.create!(pix: true, boleto:true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
      neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
      minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

    cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
    cliente.build_client_datum(cpf: "97498970058")
    cliente.save!

    extra_service = ExtraService.new(decoration: true)
    order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                          amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)

    login_as user
    visit root_path
    click_on "Pedidos"
    click_on order.code

    fill_in "Valor Final",	with: "900" 
    fill_in "Motivo do Valor Final",	with: "Imposto e taxa do site"
    fill_in "Validade do Pedido",	with: Date.current
    choose "Boleto"
    click_on "Cadastrar Valor Final"

    expect(page).to have_content "Adicionado valor final com sucesso"
    expect(page).to have_content "Status do Pedido: Aguardando a Análise do Cliente" 
  end

  it 'e cadastra o valor final com sucesso sem justificativa' do 
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
                          amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)

    login_as user
    visit root_path
    click_on "Pedidos"
    click_on order.code

    fill_in "Valor Final",	with: "1370" 
    fill_in "Motivo do Valor Final",	with: ""
    fill_in "Validade do Pedido",	with: Date.current
    choose "PIX"
    click_on "Cadastrar Valor Final"

    expect(page).to have_content "Adicionado valor final com sucesso"
    expect(page).to have_content "Status do Pedido: Aguardando a Análise do Cliente" 
  end

  it 'deixa todos os campos vázios' do 
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
                          amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)

    login_as user
    visit root_path
    click_on "Pedidos"
    click_on order.code

    click_on "Cadastrar Valor Final"

    expect(page).to have_content "Há 1 erros encontrados:"
    expect(page).to have_content "Valor Final obrigatório" 
  end

  it 'deixa todos os campos, exceto valor final vázios' do 
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
                          amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)

    login_as user
    visit root_path
    click_on "Pedidos"
    click_on order.code

    fill_in "Valor Final",	with: "500" 
    click_on "Cadastrar Valor Final"

    expect(page).to have_content "Há 3 erros encontrados:"
    expect(page).to have_content "Motivo do Valor Final precisa ser informada caso o valor seja diferente do calculado"
    expect(page).to have_content "Validade do Pedido deve ser menor ou igual a data do evento e maior ou igual a data de hoje"
    expect(page).to have_content "Forma de pagamento deve ser especificado" 
  end
end
