require 'rails_helper'

describe "Cliente após ter ocorrido o evento do buffet, acessa a página do pedido" do
  it 'Avalia o buffet com nota 7 e falha' do 
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
    order.approved!

    allow(Date).to receive(:current).and_return Date.current+2

    login_as cliente
    visit root_path
    click_on "Meus pedidos"
    click_on order.code
    fill_in "Nota",	with: "7"
    fill_in "Comentário", with: "Faltou um pouquinho de sal"
    click_on "Avaliar"

    expect(page).to have_content "Há 1 erros encontrados" 
    expect(page).to have_content "Nota deve ser menor ou igual a 5" 
  end

  it 'Avalia o buffet com nota 4 e comentário, com sucesso' do 
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
    order.approved!

    allow(Date).to receive(:current).and_return Date.current+2

    login_as cliente
    visit root_path
    click_on "Meus pedidos"
    click_on order.code
    fill_in "Nota",	with: "4"
    fill_in "Comentário", with: "Muito bom!"
    attach_file 'Inserir Imagem', Rails.root.join('spec', 'support', 'imgs', 'festaBuffet.jpg')

    click_on "Avaliar"

    expect(page).to have_content "Comentário adicionado com sucesso" 
    expect(page).to have_content "Sua avaliação:"
    expect(page).to have_content "Nota: 4/5"
    expect(page).to have_content "Comentário: Muito bom!"
    expect(page).to have_css('img[src*="festaBuffet.jpg"]')

  end

  it 'Avalia o buffet com nota 5 e sem comentário, com sucesso' do 
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
    order.approved!

    allow(Date).to receive(:current).and_return Date.current+2

    login_as cliente
    visit root_path
    click_on "Meus pedidos"
    click_on order.code
    fill_in "Nota",	with: "5"
    fill_in "Comentário", with: "Ótimo!"
    click_on "Avaliar"

    expect(page).to have_content "Comentário adicionado com sucesso" 
    expect(page).to have_content "Sua avaliação:"
    expect(page).to have_content "Nota: 5/5"
    expect(page).to have_content "Comentário: Ótimo!"
  end
end
