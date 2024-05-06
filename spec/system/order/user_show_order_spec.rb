require 'rails_helper'

describe 'Usuário acessa página de visualização do pedido' do 

  context "Sendo um cliente e Vê a página" do
    context "Aguardando a analise do buffet" do
      it 'Um pedido dentro do buffet' do 
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
  
        expect(page).to have_content "Detalhes do Pedido" 
        expect(page).to have_content "Status do Pedido: Aguardando Análise do Buffet" 
        expect(page).to have_content "Nome do Buffet: Buffet da familia" 
        expect(page).to have_content "Telefone: 7995876812" 
        expect(page).to have_content "E-mail: Maria@teste.com" 
        expect(page).to have_content "Serviço contratado: Chá de revelação" 
        expect(page).to have_content "Serviço dentro do Buffet"
        expect(page).not_to have_content "Serviço no endereço informado pelo cliente"
        expect(page).to have_content "Logradouro: Quadra 1112 Sul Alameda 5 N°: 25A Bairro: Plano Diretor Sul"
        expect(page).to have_content "Estado: TO Cidade: Palmas CEP: 77024-171 Complemento:"
        expect(page).to have_content "Número de participantes no evento: 54" 
        expect(page).to have_content "Duração do Evento: 35 minutos"
        expect(page).to have_content "Data do evento: #{I18n.l(order.date)} - #{order.type_of_day}"
        expect(page).to have_content "Serviço de decorações"
        expect(page).to have_content "Valor calculado: #{ActiveSupport::NumberHelper.number_to_currency(order.calculated_value)}" 
        expect(page).to have_button "Editar Pedido" 
        expect(page).to have_button "Cancelar Pedido" 
      end
  
      it 'Um pedido fora do buffet' do 
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
  
        expect(page).not_to have_content "Serviço dentro do Buffet"
        expect(page).to have_content "Serviço no endereço informado pelo cliente"
        expect(page).to have_content "Logradouro: Alameda Chile N°: 69 Bairro: Jardim Europa"
        expect(page).to have_content "Estado: AC Cidade: Rio Branco CEP: 69915485 Complemento:"
        expect(page).not_to have_content "Logradouro: Quadra 1112 Sul Alameda 5 N°: 25A Bairro: Plano Diretor Sul"
        expect(page).not_to have_content "Estado: TO Cidade: Palmas CEP: 77024-171 Complemento:"
        expect(page).to have_content "Data do evento: #{I18n.l(order.date)} - #{order.type_of_day}"
        expect(page).to have_content "Valor calculado: #{ActiveSupport::NumberHelper.number_to_currency(order.calculated_value)}" 
        expect(page).to have_button "Editar Pedido" 
        expect(page).to have_button "Cancelar Pedido" 
      end
    end

    context "Aguardando a analise do client" do
      it 'Um pedido com justificativa' do 
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
                              final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now , payment_method: "pix")
        order.waiting_for_client_review!
        login_as cliente
        visit root_path
        click_on "Meus pedidos"
        click_on "GZHPQ5GO"
  
        expect(page).not_to have_content "Status do Pedido: Aguardando Análise do Buffet" 
        expect(page).to have_content "Status do Pedido: Aguardando a Análise do Cliente"
        expect(page).to have_content "Valor Final: R$ 55,00"
        expect(page).to have_content "Prazo do aceite do cliente: #{I18n.l(Date.current+1)}" 
        expect(page).to have_content "Justificativa do valor: Imposto" 
        expect(page).to have_content "Forma de pagamento: PIX" 
        expect(page).not_to have_button "Editar Valor Final" 
        expect(page).to have_button "Editar Pedido" 
        expect(page).to have_button "Cancelar Pedido" 
      end
    end
    
  end

  context "Sendo uma empresa e Vê a página" do

    context "Aguardando a analise do buffet" do
      it 'Um pedido dentro do buffet sem pedidos agendado no dia' do 
        user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)
      
        payment_method = PaymentMethod.create!(pix: true, boleto: true, credit_card: true)
    
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
        order2 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 5.day.from_now, 
                              amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
        login_as user
        visit root_path
        click_on "Pedidos"
        click_on order.code
        
        expect(page).to have_content "Detalhes do Pedido" 
        expect(page).to have_content "Status do Pedido: Aguardando Análise do Buffet" 
        expect(page).to have_content "Nome do Buffet: Buffet da familia" 
        expect(page).to have_content "Telefone: 7995876812" 
        expect(page).to have_content "E-mail: Maria@teste.com" 
        expect(page).to have_content "Serviço contratado: Chá de revelação" 
        expect(page).to have_content "Serviço dentro do Buffet"
        expect(page).not_to have_content "Serviço no endereço informado pelo cliente"
        expect(page).to have_content "Logradouro: Quadra 1112 Sul Alameda 5 N°: 25A Bairro: Plano Diretor Sul"
        expect(page).to have_content "Estado: TO Cidade: Palmas CEP: 77024-171 Complemento:"
        expect(page).to have_content "Número de participantes no evento: 54" 
        expect(page).to have_content "Duração do Evento: 35 minutos"
        expect(page).to have_content "Data do evento: #{I18n.l(order.date)} - #{order.type_of_day}"
        expect(page).to have_content "Serviço de decorações"
        expect(page).to have_content "Valor calculado: #{ActiveSupport::NumberHelper.number_to_currency(order.calculated_value)}" 
        expect(page).to have_content "Qual será o valor final?" 
        expect(page).to have_field "Valor Final"
        expect(page).to have_field "Motivo do Valor Final" 
        expect(page).to have_field "Validade do Pedido" 
        expect(page).to have_field "PIX"
        expect(page).to have_field "Cartão de Crédito"
        expect(page).to have_field "Boleto"
        expect(page).to have_button "Cadastrar Valor Final" 
        expect(page).not_to have_content "Atenção: há"
        expect(page).not_to have_button "Editar Pedido" 
        expect(page).to have_button "Cancelar Pedido" 
      end
  
      it 'Um pedido fora do buffet com um pedido aprovado no mesmo dia' do 
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
    
        extra_service = ExtraService.new(decoration: true)
        customer_address = CustomerAddress.create!(public_place: "Alameda Chile", address_number: "69", 
                neighborhood: "Jardim Europa", state: "AC", city: "Rio Branco", zip: "69915485", complement: "")
        order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                  amount_of_people: 54, duration: 35, inside_the_buffet: false, extra_service: extra_service, customer_address: customer_address)
        order2 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                amount_of_people: 54, duration: 35, inside_the_buffet: false, extra_service: extra_service, customer_address: customer_address,
                final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now , payment_method: "pix")
  
        order2.approved!
        login_as user
        visit root_path
        click_on "Pedidos"
        click_on order.code
  
        expect(page).not_to have_content "Serviço dentro do Buffet"
        expect(page).to have_content "Serviço no endereço informado pelo cliente"
        expect(page).to have_content "Logradouro: Alameda Chile N°: 69 Bairro: Jardim Europa"
        expect(page).to have_content "Estado: AC Cidade: Rio Branco CEP: 69915485 Complemento:"
        expect(page).not_to have_content "Logradouro: Quadra 1112 Sul Alameda 5 N°: 25A Bairro: Plano Diretor Sul"
        expect(page).not_to have_content "Estado: TO Cidade: Palmas CEP: 77024-171 Complemento:"
        expect(page).to have_content "Data do evento: #{I18n.l(order.date)} - #{order.type_of_day}"
        expect(page).to have_content "Valor calculado: #{ActiveSupport::NumberHelper.number_to_currency(order.calculated_value)}" 
        expect(page).to have_content "Atenção: há 1 pedido aprovado(s) para este dia"
        expect(page).not_to have_button "Editar Pedido" 
        expect(page).to have_button "Cancelar Pedido" 
      end
  
      
      it 'Um pedido dentro do buffet com dois pedidos aprovados no mesmo dia, um esperando o cliente e outro  aguardando aprovação do mesmo dia' do 
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
    
        extra_service = ExtraService.new(decoration: true)
        order = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)
        order2 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
                      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now , payment_method: "pix")
        order3 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
                      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now , payment_method: "pix")           
        order4 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
                      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now , payment_method: "pix")  
        order5 = Order.create!(user: cliente, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service)  
        order2.approved!
        order3.approved!
        order4.waiting_for_client_review!
  
  
        login_as user
        visit root_path
        click_on "Pedidos"
        click_on order.code
        
        expect(page).to have_content "Atenção: há 2 pedidos aprovado(s) para este dia"
        expect(page).to have_content "Atenção: há 1 pedido aguardando a aprovação do cliente para este dia"
        expect(page).to have_content "Atenção: há 1 pedido aguardando a sua avaliação para este dia" 
      end
  
    end
    
    context "Aguardando a analise do cliente" do
      it 'Um pedido dentro do buffet sem pedidos agendado no dia' do 
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
                              amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
                              final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now , payment_method: "pix")

        order.waiting_for_client_review!

        login_as user
        visit root_path
        click_on "Pedidos"
        click_on order.code
        
        expect(page).to have_content "Status do Pedido: Aguardando a Análise do Cliente"
        expect(page).to have_content "Valor Final: R$ 55,00"
        expect(page).to have_content "Prazo do aceite do cliente: #{I18n.l(Date.current+1)}" 
        expect(page).to have_content "Justificativa do valor: Imposto" 
        expect(page).to have_button "Editar Valor Final" 
        expect(page).to have_button "Cancelar Pedido" 
      end
    end

  end

end