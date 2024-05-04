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
      click_on buffet_registration.trading_name
      click_on event.name
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
      click_on buffet_registration.trading_name
      click_on event.name
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
      expect(page).not_to have_content "Qual o Endereço onde será realizado o serviço?"  
      expect(page).to  have_field "Dentro do Buffet"
      expect(page).to  have_field "Em outro endereço"
      expect(page).to  have_field "Quantidade de Pessoas"
      expect(page).to  have_content "Quantidade mínima: 10"
      expect(page).to  have_content "Quantidade máxima: 55"
      expect(page).to  have_field "Duração do Evento (minutos)"
      expect(page).to  have_content "Duração Padrão: 63 minutos"
      expect(page).to  have_content "Serviços Adicionais"
      expect(page).to  have_field "Bebidas Alcoólicas"
      expect(page).to  have_field "Decorações"
      expect(page).not_to  have_field "Serviço de Valete/Estacionamento"
      expect(page).to  have_field "Observação"
      expect(page).to  have_button "Revisar Solicitação"
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
      click_on buffet_registration.trading_name
      click_on event.name
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
      click_on buffet_registration.trading_name
      click_on event.name
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

  context "preenchendo a página e submetendo" do 
    
  end
end