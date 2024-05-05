require 'rails_helper'

describe 'Usuário acessa Meus Pedidos / Pedidos' do 

  context "Cliente acessa Meus Pedidos" do

    it 'E há 2 pedidos aguardando a avaliação do buffet, 1 aprovado, 1 aguardando a avaliação do cliente e 1 cancelado' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
      
      payment_method = PaymentMethod.create!(pix: true)

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
      order2 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      order3 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      order4 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      order5 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      
      order3.waiting_for_client_review!
      order4.approved!
      order5.canceled!

      other_client = User.new(name: "Sofia", last_name: "Oliveira", email: 'oliveira@teste.com', password: 'teste123', company: false)
      other_client.build_client_datum(cpf: "10669230006")
      other_client.save!
      order_other_client = Order.create!(user: other_client, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)

      login_as cliente
      visit root_path
      click_on "Meus pedidos"

      expect(page).to have_content "Pedidos Aguardando a Aprovação do Buffet:"
      expect(page).to have_link order.code 
      expect(page).to have_link order2.code 
      expect(page).to have_content "Pedidos Aguardando a sua avaliação:"
      expect(page).not_to have_content "Não há pedidos aguardando a sua avaliação"
      expect(page).to have_link order3.code 
      expect(page).to have_content "Pedidos Aprovados:"
      expect(page).not_to have_content "Não há pedidos aprovados"
      expect(page).to have_link order4.code 
      expect(page).to have_content "Pedidos Cancelados:" 
      expect(page).not_to have_content "Não há pedidos cancelados"
      expect(page).to have_link order5.code 
      expect(page).not_to have_link order_other_client.code
    end

    it 'Não há pedidos' do
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!


      login_as cliente
      visit root_path
      click_on "Meus pedidos"

      expect(page).to have_content "Não há pedidos sendo aguardado" 
      expect(page).to have_content "Não há pedidos aguardando a sua avaliação"
      expect(page).to have_content "Não há pedidos aprovados"
      expect(page).to have_content "Não há pedidos cancelados"
    end

  end
  
  context "Empresa acessa Pedidos" do
    it 'E há 2 pedidos aguardando a avaliação do buffet, 1 aprovado, 1 aguardando a avaliação do cliente e 1 cancelado' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
      
      payment_method = PaymentMethod.create!(pix: true)

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
      order2 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      order3 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      order4 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      order5 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      
      order3.waiting_for_client_review!
      order4.approved!
      order5.canceled!

      other_client = User.new(name: "Sofia", last_name: "Oliveira", email: 'oliveira@teste.com', password: 'teste123', company: false)
      other_client.build_client_datum(cpf: "10669230006")
      other_client.save!
      order_other_client = Order.create!(user: other_client, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)

      login_as cliente
      visit root_path
      click_on "Meus pedidos"

      expect(page).to have_content "Pedidos Aguardando a Aprovação do Buffet:"
      expect(page).to have_link order.code 
      expect(page).to have_link order2.code 
      expect(page).to have_content "Pedidos Aguardando a sua avaliação:"
      expect(page).not_to have_content "Não há pedidos aguardando a sua avaliação"
      expect(page).to have_link order3.code 
      expect(page).to have_content "Pedidos Aprovados:"
      expect(page).not_to have_content "Não há pedidos aprovados"
      expect(page).to have_link order4.code 
      expect(page).to have_content "Pedidos Cancelados:" 
      expect(page).not_to have_content "Não há pedidos cancelados"
      expect(page).to have_link order5.code 
      expect(page).not_to have_link order_other_client.code
    end

    it 'Não há pedidos' do
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!


      login_as cliente
      visit root_path
      click_on "Meus pedidos"

      expect(page).to have_content "Não há pedidos sendo aguardado" 
      expect(page).to have_content "Não há pedidos aguardando a sua avaliação"
      expect(page).to have_content "Não há pedidos aprovados"
      expect(page).to have_content "Não há pedidos cancelados"
    end
  end

end