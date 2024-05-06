require 'rails_helper'

describe "Cliente Autenticado clica em Editar Pedido" do 
  context "visualizando a página de edição" do
    it 'Visualiza a página de editar Pedido, de um evento apenas dentro do buffet' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: false, decoration: true, valet: false, insider: true, outsider: false, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"
  
      expect(page).to have_content "Edição do pedido: GZHPQ5GO"
      expect(page).to have_content "Nome do Buffet: Buffet da familia"
      expect(page).to have_content "Telefone: 7995876812"
      expect(page).to have_content "E-mail: Maria@teste.com"
      expect(page).to have_content "Serviço a ser contratado: Chá de revelação"
      expect(page).to have_content "Serviço só pode ser realizado dentro do Buffet"
      expect(page).not_to have_content "Onde será realizado o serviço?"
      expect(page).not_to have_content "Serviço só pode ser realizado no local indicado pelo cliente abaixo:"
      expect(page).to have_content "Logradouro: Quadra 1112 Sul Alameda 5 N°: 25A Bairro: Plano Diretor Sul"
      expect(page).to have_content "Estado: TO Cidade: Palmas CEP: 77024-171 Complemento:"
      expect(page).to have_field "Participantes do Evento", with: "54" 
      expect(page).to have_field "Duração do Evento (minutos)", with: "35"
      expect(page).to have_field "Data", with: "#{Date.current+1}" 
      expect(page).to have_checked_field "Decorações"
    end
  
    it 'Visualiza a página de editar Pedido, de um evento apenas no local indicado pelo cliente' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: false, decoration: true, valet: false, insider: false, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      customer_address = CustomerAddress.create!(public_place: "Alameda Chile", address_number: "69", 
                          neighborhood: "Jardim Europa", state: "AC", city: "Rio Branco", zip: "69915485", complement: "")
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: false, extra_service: extra_service, customer_address: customer_address)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"
  
      expect(page).to have_content "Edição do pedido: GZHPQ5GO"
      expect(page).to have_content "Nome do Buffet: Buffet da familia"
      expect(page).to have_content "Telefone: 7995876812"
      expect(page).to have_content "E-mail: Maria@teste.com"
      expect(page).to have_content "Serviço a ser contratado: Chá de revelação"
      expect(page).not_to have_content "Serviço só pode ser realizado dentro do Buffet"
      expect(page).not_to have_content "Onde será realizado o serviço?"
      expect(page).to have_content "Serviço só pode ser realizado no local indicado pelo cliente abaixo:"
      expect(page).to have_field "Logradouro", with: 'Alameda Chile'
      expect(page).to have_field "N°", with: '69'
      expect(page).to have_field "Bairro", with: 'Jardim Europa'
      expect(page).to have_field "Estado", with: 'AC'
      expect(page).to have_field "Cidade", with: 'Rio Branco'
      expect(page).to have_field "CEP", with: '69915485'
      expect(page).to have_field "Complemento", with: ''
      expect(page).not_to have_content "Logradouro: Quadra 1112 Sul Alameda 5 N°: 25A Bairro: Plano Diretor Sul"
      expect(page).not_to have_content "Estado: TO Cidade: Palmas CEP: 77024-171 Complemento:"
      expect(page).to have_field "Participantes do Evento", with: "54" 
      expect(page).to have_field "Duração do Evento (minutos)", with: "35"
      expect(page).to have_field "Data", with: "#{Date.current+1}" 
      expect(page).to have_checked_field "Decorações"
    end
  
    it 'Visualiza a página de editar Pedido, de um evento fora do buffet, podendo ser dentro ou fora do buffet' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(valet:true, alcoholic_beverages: true )
      customer_address = CustomerAddress.create!(public_place: "Alameda Chile", address_number: "69", 
                          neighborhood: "Jardim Europa", state: "AC", city: "Rio Branco", zip: "69915485", complement: "")
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: false, extra_service: extra_service, customer_address: customer_address)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"
  
      expect(page).to have_content "Edição do pedido: GZHPQ5GO"
      expect(page).to have_content "Nome do Buffet: Buffet da familia"
      expect(page).to have_content "Telefone: 7995876812"
      expect(page).to have_content "E-mail: Maria@teste.com"
      expect(page).to have_content "Serviço a ser contratado: Chá de revelação"
      expect(page).not_to have_content "Serviço só pode ser realizado dentro do Buffet"
      expect(page).to have_content "Onde será realizado o serviço?"
      expect(page).to  have_button "Dentro do Buffet"
      expect(page).to  have_button "Em outro endereço", disabled: true
      expect(page).not_to have_content "Serviço só pode ser realizado no local indicado pelo cliente abaixo:"
      expect(page).to have_field "Logradouro", with: 'Alameda Chile'
      expect(page).to have_field "N°", with: '69'
      expect(page).to have_field "Bairro", with: 'Jardim Europa'
      expect(page).to have_field "Estado", with: 'AC'
      expect(page).to have_field "Cidade", with: 'Rio Branco'
      expect(page).to have_field "CEP", with: '69915485'
      expect(page).to have_field "Complemento", with: ''
      expect(page).not_to have_content "Logradouro: Quadra 1112 Sul Alameda 5 N°: 25A Bairro: Plano Diretor Sul"
      expect(page).not_to have_content "Estado: TO Cidade: Palmas CEP: 77024-171 Complemento:"
      expect(page).to have_field "Participantes do Evento", with: "54" 
      expect(page).to have_field "Duração do Evento (minutos)", with: "35"
      expect(page).to have_field "Data", with: "#{Date.current+1}" 
      expect(page).to have_unchecked_field "Decorações"
      expect(page).to have_checked_field "Bebidas Alcoólicas" 
      expect(page).to have_checked_field "Serviço de Valete/Estacionamento" 
    end
  
    it 'Visualiza a página de editar Pedido, de um evento dentro do buffet, podendo ser dentro ou fora do buffet' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"
  
      expect(page).to have_content "Edição do pedido: GZHPQ5GO"
      expect(page).to have_content "Nome do Buffet: Buffet da familia"
      expect(page).to have_content "Telefone: 7995876812"
      expect(page).to have_content "E-mail: Maria@teste.com"
      expect(page).to have_content "Serviço a ser contratado: Chá de revelação"
      expect(page).not_to have_content "Serviço só pode ser realizado dentro do Buffet"
      expect(page).to have_content "Onde será realizado o serviço?"
      expect(page).to  have_button "Dentro do Buffet", disabled: true
      expect(page).to  have_button "Em outro endereço"
      expect(page).not_to have_content "Serviço só pode ser realizado no local indicado pelo cliente abaixo:"
      expect(page).to have_content "Logradouro: Quadra 1112 Sul Alameda 5 N°: 25A Bairro: Plano Diretor Sul"
      expect(page).to have_content "Estado: TO Cidade: Palmas CEP: 77024-171 Complemento:"
      expect(page).to have_field "Participantes do Evento", with: "54" 
      expect(page).to have_field "Duração do Evento (minutos)", with: "35"
      expect(page).to have_field "Data", with: "#{Date.current+1}" 
      expect(page).to have_checked_field "Decorações"
      expect(page).to have_unchecked_field "Bebidas Alcoólicas" 
      expect(page).to have_unchecked_field "Serviço de Valete/Estacionamento" 
    end
  end
  
  context "Editando com Sucesso" do
    it 'Pedido com um evento apenas dentro do buffet' do 
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
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      fill_in "Participantes do Evento",	with: "50" 
      fill_in "Duração do Evento",	with: "80" 
      check "Bebidas Alcoólicas"
      check "Serviço de Valete/Estacionamento"
      uncheck "Decorações"

      click_on "Submeter"

      expect(current_path).to eq order_path(order)
      expect(page).to have_content "Pedido Atualizado com sucesso"
    end

    it 'Pedido com um evento apenas fora do buffet' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: false, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      customer_address = CustomerAddress.create!(public_place: "Alameda Chile", address_number: "69", 
                          neighborhood: "Jardim Europa", state: "AC", city: "Rio Branco", zip: "69915485", complement: "")
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
              amount_of_people: 54, duration: 35, inside_the_buffet: false, extra_service: extra_service, customer_address: customer_address)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      fill_in "Participantes do Evento",	with: "24" 
      fill_in "Duração do Evento",	with: "68" 
      fill_in "Logradouro",	with: "Rua Sao Maritano" 
      fill_in "N°",	with: "15" 
      fill_in "Bairro",	with: "São Jorge" 
      fill_in "Estado",	with: "Sergipe" 
      fill_in "Cidade",	with: "Arara" 
      fill_in "CEP",	with: "36595-400"
      fill_in "Complemento",	with: "Próximo ao super mercado" 
      check "Bebidas Alcoólicas"

      click_on "Submeter"

      expect(current_path).to eq order_path(order)
      expect(page).to have_content "Pedido Atualizado com sucesso"
    end

    it 'Pedido com um evento fora do buffet, podendo ser dentro ou fora do buffet' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      customer_address = CustomerAddress.create!(public_place: "Alameda Chile", address_number: "69", 
                          neighborhood: "Jardim Europa", state: "AC", city: "Rio Branco", zip: "69915485", complement: "")
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
              amount_of_people: 54, duration: 35, inside_the_buffet: false, extra_service: extra_service, customer_address: customer_address)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      click_on "Dentro do Buffet"

      click_on "Submeter"

      expect(current_path).to eq order_path(order)
      expect(page).to have_content "Pedido Atualizado com sucesso"
    end

    it 'Pedido com um evento dentro do buffet, podendo ser dentro ou fora do buffet' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
              amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      click_on "Em outro endereço"

      fill_in "Logradouro",	with: "Rua Sao Maritano" 
      fill_in "N°",	with: "15" 
      fill_in "Bairro",	with: "São Jorge" 
      fill_in "Estado",	with: "Sergipe" 
      fill_in "Cidade",	with: "Arara" 
      fill_in "CEP",	with: "36595-400"
      fill_in "Complemento",	with: "Próximo ao super mercado" 

      click_on "Submeter"

      expect(current_path).to eq order_path(order)
      expect(page).to have_content "Pedido Atualizado com sucesso"
    end
  end

  context "editando com falha" do
    it 'Pedido com um evento apenas dentro do buffet' do 
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
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      fill_in "Participantes do Evento",	with: "50" 
      fill_in "Duração do Evento",	with: "" 
      check "Bebidas Alcoólicas"
      check "Serviço de Valete/Estacionamento"
      uncheck "Decorações"

      click_on "Submeter"

      expect(current_path).not_to eq order_path(order)
      expect(page).to have_content "Há 1 erros encontrados:" 
      expect(page).to have_content "Duração do Evento (minutos) não pode ficar em branco" 
      expect(page).not_to have_content "Pedido Atualizado com sucesso"
    end

    it 'Pedido com um evento apenas fora do buffet' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: false, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      customer_address = CustomerAddress.create!(public_place: "Alameda Chile", address_number: "69", 
                          neighborhood: "Jardim Europa", state: "AC", city: "Rio Branco", zip: "69915485", complement: "")
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
              amount_of_people: 54, duration: 35, inside_the_buffet: false, extra_service: extra_service, customer_address: customer_address)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      fill_in "Participantes do Evento",	with: "24" 
      fill_in "Duração do Evento",	with: "68" 
      fill_in "Logradouro",	with: "Rua Sao Maritano" 
      fill_in "N°",	with: "15" 
      fill_in "Bairro",	with: "" 
      fill_in "Estado",	with: "Sergipe" 
      fill_in "Cidade",	with: "Arara" 
      fill_in "CEP",	with: ""
      fill_in "Complemento",	with: "Próximo ao super mercado" 
      check "Bebidas Alcoólicas"

      click_on "Submeter"

      expect(current_path).not_to eq order_path(order)
      expect(page).to have_content "Há 2 erros encontrados:" 
      expect(page).to have_content "Bairro não pode ficar em branco" 
      expect(page).to have_content "CEP não pode ficar em branco" 
      expect(page).not_to have_content "Pedido Atualizado com sucesso"
    end

    it 'Pedido com um evento fora do buffet, podendo ser dentro ou fora do buffet' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      customer_address = CustomerAddress.create!(public_place: "Alameda Chile", address_number: "69", 
                          neighborhood: "Jardim Europa", state: "AC", city: "Rio Branco", zip: "69915485", complement: "")
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
              amount_of_people: 54, duration: 35, inside_the_buffet: false, extra_service: extra_service, customer_address: customer_address)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      click_on "Dentro do Buffet"
      fill_in "Duração do Evento",	with: "" 
      click_on "Submeter"

      expect(current_path).not_to eq order_path(order)
      expect(page).to have_content "Há 1 erros encontrados:" 
      expect(page).to have_content "Duração do Evento (minutos) não pode ficar em branco" 
      expect(page).not_to have_content "Pedido Atualizado com sucesso"
    end

    it 'Pedido com um evento dentro do buffet, podendo ser dentro ou fora do buffet' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
    
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
              amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      click_on "Em outro endereço"

      fill_in "Logradouro",	with: "Rua Sao Maritano" 
      fill_in "N°",	with: "15" 
      fill_in "Bairro",	with: "" 
      fill_in "Estado",	with: "Sergipe" 
      fill_in "Cidade",	with: "Arara" 
      fill_in "CEP",	with: ""
      fill_in "Complemento",	with: "Próximo ao super mercado" 

      click_on "Submeter"

      expect(current_path).not_to eq order_path(order)
      expect(page).to have_content "Há 2 erros encontrados:" 
      expect(page).to have_content "Bairro não pode ficar em branco" 
      expect(page).to have_content "CEP não pode ficar em branco" 
      expect(page).not_to have_content "Pedido Atualizado com sucesso"
    end
  end

  context "Pedidos Aguardando o cliente" do 
    it 'Com sucesso' do 
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
  
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                            amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
              final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")
      order.waiting_for_client_review!
                
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      fill_in "Participantes do Evento",	with: "50" 
      fill_in "Duração do Evento",	with: "80" 
      check "Bebidas Alcoólicas"
      check "Serviço de Valete/Estacionamento"
      uncheck "Decorações"

      click_on "Submeter"

      expect(current_path).to eq order_path(order)
      expect(page).to have_content "Pedido Atualizado com sucesso"
      expect(page).to have_content "Status do Pedido: Aguardando Análise do Buffet"

    end

    it 'Com falha' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
      
      payment_method = PaymentMethod.create!(pix: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: false, outsider: true, user: user)

      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!

      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GZHPQ5GO')
      extra_service = ExtraService.new(decoration: true)
      customer_address = CustomerAddress.create!(public_place: "Alameda Chile", address_number: "69", 
                          neighborhood: "Jardim Europa", state: "AC", city: "Rio Branco", zip: "69915485", complement: "")
      order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
              amount_of_people: 54, duration: 35, inside_the_buffet: false, extra_service: extra_service, customer_address: customer_address,
              final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")

      order.waiting_for_client_review!
      
      login_as cliente
      visit root_path
      click_on "Meus pedidos"
      click_on "GZHPQ5GO"
      click_on "Editar Pedido"

      fill_in "Participantes do Evento",	with: "24" 
      fill_in "Duração do Evento",	with: "68" 
      fill_in "Logradouro",	with: "Rua Sao Maritano" 
      fill_in "N°",	with: "15" 
      fill_in "Bairro",	with: "" 
      fill_in "Estado",	with: "Sergipe" 
      fill_in "Cidade",	with: "Arara" 
      fill_in "CEP",	with: ""
      fill_in "Complemento",	with: "Próximo ao super mercado" 
      check "Bebidas Alcoólicas"

      click_on "Submeter"

      expect(current_path).not_to eq order_path(order)
      expect(page).to have_content "Há 2 erros encontrados:" 
      expect(page).to have_content "Bairro não pode ficar em branco" 
      expect(page).to have_content "CEP não pode ficar em branco" 
      expect(page).not_to have_content "Pedido Atualizado com sucesso"
    end

  end
end