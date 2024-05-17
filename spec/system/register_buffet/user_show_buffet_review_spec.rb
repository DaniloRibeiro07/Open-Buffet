require 'rails_helper'

describe "Usuário acessa a página de exibição do buffet" do 
  it "E vê a média de avaliações e comentários" do 
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
    order1 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
            final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")
    
    order1.create_evaluation!(score: 3, comment: "Ambiente insalubre")

    order2 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")

    order2.create_evaluation!(score: 5, comment: "Comida muito gostosa")

    order2.evaluation.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario.jpeg')), filename: 'festa_de_aniversario.jpeg')
    order2.evaluation.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario2.jpg')), filename: 'festa_de_aniversario2.jpg')

    order3= Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")



    order3.create_evaluation!(score: 4, comment: "Poderia aumentar a variedade")

    order4= Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")

    order4.create_evaluation!(score: 1, comment: "Muito caro para o que é servido")

    visit root_path

    click_on "Buffet da familia"

    expect(page).to have_content "Média: 3.3 de 5"
    expect(page).to have_content "Comentário: Muito caro para o que é servido"
    expect(page).to have_content "Comentário: Poderia aumentar a variedade"
    expect(page).to have_content "Comentário: Comida muito gostosa"
    expect(page).to have_css('img[src*="festa_de_aniversario2.jpg"]')
    expect(page).to have_css('img[src*="festa_de_aniversario.jpeg"]')
    expect(page).to have_link "Vê mais avaliações"
  end

  it "E o buffet não possui comentários" do 
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

    visit root_path

    click_on "Buffet da familia"

    expect(page).to have_content "Ainda não há avaliações"
    expect(page).not_to have_link "Vê mais avaliações"
  end

  it "E acessa a página de vê mais avaliações" do 
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
    order1 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
            final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")
    
    order1.create_evaluation!(score: 3, comment: "Ambiente insalubre")

    order2 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")

    order2.create_evaluation!(score: 5, comment: "Comida muito gostosa")

    order2.evaluation.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario.jpeg')), filename: 'festa_de_aniversario.jpeg')
    order2.evaluation.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario2.jpg')), filename: 'festa_de_aniversario2.jpg')


    order3= Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")

    order3.create_evaluation!(score: 4, comment: "Poderia aumentar a variedade")

    order4= Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")

    order4.create_evaluation!(score: 1, comment: "Muito caro para o que é servido")
    

    visit root_path

    click_on "Buffet da familia"
    click_on "Vê mais avaliações"

    expect(page).to have_content "Média: 3.3 de 5"
    expect(page).to have_content "Comentário: Muito caro para o que é servido"
    expect(page).to have_css('img[src*="festa_de_aniversario2.jpg"]')
    expect(page).to have_css('img[src*="festa_de_aniversario.jpeg"]')
    expect(page).to have_content "Comentário: Poderia aumentar a variedade"
    expect(page).to have_content "Comentário: Comida muito gostosa"
    expect(page).to have_content "Comentário: Ambiente insalubre"
    expect(page).to have_button "Voltar"

  end
end