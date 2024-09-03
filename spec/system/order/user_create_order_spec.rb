require 'rails_helper'

describe 'Usuário clica em fazer um pedido' do 

  context "visualizacao de página em diversos cenários" do
    it 'Sendo um visitante e é redirecionado para login' do 
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
  
      visit root_path
      within 'div#17924491000160' do
        click_on "Detalhes"
      end
      click_on 'Chá de revelação'
      click_on "Fazer um pedido"
  
      expect(current_path).to eq new_user_session_path  
    end
  
    it 'Sendo um cliente e vê a página de criação com valor diferente na semana e local para escolher com serviço adicional de decoração e bebidas' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
  
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
      event_value2 = EventValue.create!(base_price: 80.00, price_per_person: 60, overtime_rate: 56)
  
      event = EventType.create!(different_weekend: true , weekend_price: event_value2, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: true, decoration: true, valet: false, insider: true, outsider: true, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      login_as cliente
  
      visit root_path
      within 'div#17924491000160' do
        click_on "Detalhes"
      end
      click_on 'Chá de revelação'
      click_on "Fazer um pedido"
  
      expect(current_path).to eq new_event_type_order_path(event)
      expect(page).to have_content "Solicitação de Serviço"
      expect(page).to have_content "Nome do Buffet: Buffet da familia"
      expect(page).to have_content "Telefone: 7995876812"
      expect(page).to have_content "E-mail: Maria@teste.com" 
      expect(page).to have_content "Serviço a ser contratado: Chá de revelação" 
      expect(page).to have_content "Preço base considerando a quantidade mínima de pessoas (10) e duração padrão do evento de 63 minutos: R$ 50,39 em dia útil e final de semana R$ 80,00"
      expect(page).to have_content "Incremento do preço base por pessoa acima da quantidade mínima: R$ 30,00 em dia útil e R$ 60,00 em final de semana"
      expect(page).to have_content "Incremento do preço base por exceder o tempo base: R$ 30,00 / hora em dia útil e R$ 56,00 / hora em final de semana" 
      expect(page).to have_content "O valor final está sujeito a alteração por parte do dono do buffet após a solicitação do pedido." 
      expect(page).to have_content "Onde será realizado o serviço?"
      expect(page).not_to have_content "Serviço só pode ser realizado dentro do Buffet" 
      expect(page).not_to have_content "Serviço só pode ser realizado no local indicado pelo cliente abaixo"
      expect(page).not_to have_content "Endereço do Buffet"  
      expect(page).to  have_button "Dentro do Buffet"
      expect(page).to  have_button "Em outro endereço", disabled: true
      expect(page).to  have_field "Participantes do Evento"
      expect(page).to  have_content "Quantidade mínima: 10"
      expect(page).to  have_content "Quantidade máxima: 55"
      expect(page).to  have_field "Duração do Evento (minutos)"
      expect(page).to  have_content "Duração Padrão: 63 minutos"
      expect(page).to  have_content "Serviços Adicionais"
      expect(page).to  have_field "Bebidas Alcoólicas"
      expect(page).to  have_field "Decorações"
      expect(page).not_to  have_field "Serviço de Valete/Estacionamento"
      expect(page).to  have_field "Observação"
      expect(page).to  have_button "Submeter"
      expect(page).to  have_button "Voltar"
    end
  
    it 'Sendo um cliente em um evento com serviço apenas dentro do buffet, o mesmo valor em toda semana e sem serviços adicionais' do 
      user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
  
      payment_method = PaymentMethod.create!(pix: true)
  
      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
        cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
        neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
  
      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
      event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
        minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
        alcoholic_beverages: false, decoration: false, valet: false, insider: true, outsider: false, user: user)
  
      cliente = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
      cliente.build_client_datum(cpf: "97498970058")
      cliente.save!
  
      login_as cliente
  
      visit root_path
      within 'div#17924491000160' do
        click_on "Detalhes"
      end
      click_on 'Chá de revelação'
      click_on "Fazer um pedido"
  
      expect(page).to have_content "Preço base considerando a quantidade mínima de pessoas (10) e duração padrão do evento de 63 minutos: R$ 50,39"
      expect(page).to have_content "Incremento do preço base por pessoa acima da quantidade mínima: R$ 30,00"
      expect(page).to have_content "Incremento do preço base por exceder o tempo base: R$ 30,00" 
      expect(page).not_to have_content "Onde será realizado o serviço? "
      expect(page).to have_content "Serviço só pode ser realizado dentro do Buffet" 
      expect(page).not_to have_content "Serviço só pode ser realizado no local indicado pelo cliente abaixo"
      expect(page).to have_content "Endereço do Buffet" 
      expect(page).not_to have_content "Qual o Endereço onde será realizado o serviço?"  
      expect(page).not_to  have_field "Dentro do Buffet"
      expect(page).not_to  have_field "Em outro endereço"
      expect(page).not_to have_field "Logradouro"
      expect(page).not_to have_field "N°" 
      expect(page).not_to have_field "Bairro" 
      expect(page).not_to have_field "Estado" 
      expect(page).not_to have_field "Cidade" 
      expect(page).not_to have_field "CEP" 
      expect(page).not_to have_field "Complemento"
      expect(page).not_to  have_content "Serviços Adicionais"
      expect(page).not_to  have_field "Bebidas Alcoólicas"
      expect(page).not_to  have_field "Decorações"
      expect(page).not_to  have_field "Serviço de Valete/Estacionamento"
      expect(page).to have_content "Logradouro: Quadra 1112 Sul Alameda 5" 
      expect(page).to have_content "N°: 25A" 
      expect(page).to have_content "Bairro: Plano Diretor Sul" 
      expect(page).to have_content "Estado: TO" 
      expect(page).to have_content "Cidade: Palmas" 
      expect(page).to have_content "CEP: 77024-171"
      expect(page).to have_content "Complemento:" 
    end
  
    it 'Sendo um cliente em um evento com serviço apenas fora do buffet' do 
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
  
      login_as cliente
  
      visit root_path
      within 'div#17924491000160' do
        click_on "Detalhes"
      end
      click_on 'Chá de revelação'
      click_on "Fazer um pedido"
  
      expect(page).not_to have_content "Onde será realizado o serviço? "
      expect(page).not_to have_content "Serviço só pode ser realizado dentro do Buffet" 
      expect(page).to have_content "Serviço só pode ser realizado no local indicado pelo cliente abaixo"
      expect(page).not_to have_content "Endereço do Buffet"  
      expect(page).to have_content "Qual o Endereço onde será realizado o serviço?"  
      expect(page).not_to  have_field "Dentro do Buffet"
      expect(page).not_to  have_field "Em outro endereço"
      expect(page).to have_field "Logradouro"
      expect(page).to have_field "N°" 
      expect(page).to have_field "Bairro" 
      expect(page).to have_field "Estado" 
      expect(page).to have_field "Cidade" 
      expect(page).to have_field "CEP" 
      expect(page).to have_field "Complemento" 
      expect(page).not_to have_content "Logradouro: Quadra 1112 Sul Alameda 5" 
      expect(page).not_to have_content "N°: 25A" 
      expect(page).not_to have_content "Bairro: Plano Diretor Sul" 
      expect(page).not_to have_content "Estado: TO" 
      expect(page).not_to have_content "Cidade: Palmas" 
      expect(page).not_to have_content "CEP: 77024-171"
      expect(page).not_to have_content "Complemento:" 
    end
  end

  context "preenchendo a página e submetendo com sucesso" do 
    it 'Evento apenas dentro do buffet e apenas com adicional de bebida' do 
      user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)

      payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
        minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
        alcoholic_beverages: true, decoration: false, valet: false, insider: true, outsider: false, user: user)

      visitante = User.new(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
      visitante.build_client_datum(cpf: "02241335002")
      visitante.save!

      login_as visitante 

      visit root_path
      within 'div#87088795000110' do
        click_on "Detalhes"
      end
      click_on 'Casamento'
      click_on 'Fazer um pedido'
      check 'Bebidas Alcoólicas'

      fill_in "Participantes do Evento",	with: "35" 
      fill_in "Duração do Evento (minutos)",	with: "68"
      fill_in "Data",	with: 1.day.from_now 
      click_on "Submeter"

      expect(current_path).to eq order_path(Order.last())
      expect(page).to have_content "Pedido criado com sucesso" 
    end

    it 'Evento apenas fora do buffet sem adicionais' do 
      user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)

      payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
        minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
        alcoholic_beverages: false, decoration: false, valet: false, insider: false, outsider: true, user: user)

      visitante = User.new(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
      visitante.build_client_datum(cpf: "02241335002")
      visitante.save!

      login_as visitante 

      visit root_path

      within 'div#87088795000110' do
        click_on "Detalhes"
      end
      click_on 'Casamento'
      click_on 'Fazer um pedido'

      fill_in "Logradouro",	with: "Rua Jacuípe" 
      fill_in "N°",	with: "339" 
      fill_in "Bairro",	with: "São Pedro" 
      fill_in "Estado",	with: "Bahia" 
      fill_in "Cidade",	with: "Salvador"
      fill_in "CEP",	with: "59485-100" 
      fill_in "Complemento",	with: "Próximo da praça Faustinho" 

      fill_in "Participantes do Evento",	with: "35" 
      fill_in "Duração do Evento (minutos)",	with: "68"
      fill_in "Data",	with: 1.day.from_now 
      click_on "Submeter"

      expect(page).to have_content "Pedido criado com sucesso" 
      expect(current_path).to eq order_path(Order.last())
    end

    it 'Evento pode ser dentro ou fora do buffet, usuario escolhe fora do buffet e com decoracao, bebida e valet' do 
      user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)

      payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
        minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)

      visitante = User.new(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
      visitante.build_client_datum(cpf: "02241335002")
      visitante.save!

      login_as visitante 

      visit root_path

      within 'div#87088795000110' do
        click_on "Detalhes"
      end
      click_on 'Casamento'
      click_on 'Fazer um pedido'

      fill_in "Logradouro",	with: "Rua Jacuípe" 
      fill_in "N°",	with: "339" 
      fill_in "Bairro",	with: "São Pedro" 
      fill_in "Estado",	with: "Bahia" 
      fill_in "Cidade",	with: "Salvador"
      fill_in "CEP",	with: "59485-100" 
      fill_in "Complemento",	with: "Próximo da praça Faustinho" 

      fill_in "Participantes do Evento",	with: "35" 
      fill_in "Duração do Evento (minutos)",	with: "68"
      fill_in "Data", with: 1.day.from_now
      
      check 'Bebidas Alcoólicas'
      check 'Decorações'
      check 'Serviço de Valete/Estacionamento'
      click_on "Submeter"

      expect(page).to have_content "Pedido criado com sucesso" 
      expect(current_path).to eq order_path(Order.last())
    end

    it 'Evento pode ser dentro ou fora do buffet, usuario escolhe dentro do buffet e sem adicional' do 
      user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)

      payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
        minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)

      visitante = User.new(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
      visitante.build_client_datum(cpf: "02241335002")
      visitante.save!

      login_as visitante 

      visit root_path

      within 'div#87088795000110' do
        click_on "Detalhes"
      end
      click_on 'Casamento'
      click_on 'Fazer um pedido'

      click_on 'Dentro do Buffet'

      fill_in "Participantes do Evento",	with: "35" 
      fill_in "Duração do Evento (minutos)",	with: "68"
      fill_in "Data", with: 1.day.from_now
      
      click_on "Submeter"

      expect(page).to have_content "Pedido criado com sucesso" 
      expect(current_path).to eq order_path(Order.last())
    end
  end

  context "preenchendo a página e submetendo com falha" do 
    it 'Evento apenas dentro do buffet e apenas com adicional de bebida' do 
      user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)

      payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
        minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
        alcoholic_beverages: true, decoration: false, valet: false, insider: true, outsider: false, user: user)

      visitante = User.new(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
      visitante.build_client_datum(cpf: "02241335002")
      visitante.save!

      login_as visitante 

      visit root_path
      within 'div#87088795000110' do
        click_on "Detalhes"
      end
      click_on 'Casamento'
      click_on 'Fazer um pedido'

      click_on "Submeter"

      expect(current_path).to eq event_type_orders_path(event)
      expect(page).to have_content "Há 3 erros encontrados" 
      expect(page).to have_content "Data não pode ficar em branco"
      expect(page).to have_content "Duração do Evento (minutos) não pode ficar em branco" 
      expect(page).to have_content "Participantes do Evento não pode ficar em branco"
    end

    it 'Evento apenas fora do buffet sem adicionais' do 
      user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)

      payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
        minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
        alcoholic_beverages: false, decoration: false, valet: false, insider: false, outsider: true, user: user)

      visitante = User.new(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
      visitante.build_client_datum(cpf: "02241335002")
      visitante.save!

      login_as visitante 

      visit root_path

      within 'div#87088795000110' do
        click_on "Detalhes"
      end
      click_on 'Casamento'
      click_on 'Fazer um pedido'

      click_on "Submeter"

      expect(current_path).to eq event_type_orders_path(event)
      expect(page).to have_content "Há 9 erros encontrados" 
      expect(page).to have_content "Logradouro não pode ficar em branco" 
      expect(page).to have_content "Bairro não pode ficar em branco" 
      expect(page).to have_content "Estado não pode ficar em branco" 
      expect(page).to have_content "CEP não pode ficar em branco" 
      expect(page).to have_content "Cidade não pode ficar em branco" 
      expect(page).to have_content "N° não pode ficar em branco" 
      expect(page).to have_content "Data não pode ficar em branco"
      expect(page).to have_content "Duração do Evento (minutos) não pode ficar em branco" 
      expect(page).to have_content "Participantes do Evento não pode ficar em branco"
    end

    it 'Evento pode ser dentro ou fora do buffet, usuario escolhe fora do buffet e com decoracao, bebida e valet' do 
      user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)

      payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)

      buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")

      event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
        minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)

      visitante = User.new(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
      visitante.build_client_datum(cpf: "02241335002")
      visitante.save!

      login_as visitante 

      visit root_path

      within 'div#87088795000110' do
        click_on "Detalhes"
      end
      click_on 'Casamento'
      click_on 'Fazer um pedido'

      click_on "Submeter"
      
      expect(current_path).to eq event_type_orders_path(event)
      expect(page).to have_content "Há 9 erros encontrados" 
      expect(page).to have_content "Logradouro não pode ficar em branco" 
      expect(page).to have_content "Bairro não pode ficar em branco" 
      expect(page).to have_content "Estado não pode ficar em branco" 
      expect(page).to have_content "CEP não pode ficar em branco" 
      expect(page).to have_content "Cidade não pode ficar em branco" 
      expect(page).to have_content "N° não pode ficar em branco" 
      expect(page).to have_content "Data não pode ficar em branco"
      expect(page).to have_content "Duração do Evento (minutos) não pode ficar em branco" 
      expect(page).to have_content "Participantes do Evento não pode ficar em branco"
    end

    
  end
  
end