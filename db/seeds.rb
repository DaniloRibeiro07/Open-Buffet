# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

visitante1 = User.new(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
visitante1.build_client_datum(cpf: "02241335002")
visitante1.save!

visitante2 = User.new(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
visitante2.build_client_datum(cpf: "97498970058")
visitante2.save!

visitante3 = User.new(name: "Olivia", last_name: "Rodrigo", email: 'Olivia@teste.com', password: 'teste123', company: false)
visitante3.build_client_datum(cpf: "74890617094")
visitante3.save!


user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)

payment_method = PaymentMethod.create!(pix: true)

buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
  cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
  neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
  buffet_registration: buffet_registration, name: "Chá de revelação", description: "Chá de revelação para novos pais ",
  minimum_quantity: 10, maximum_quantity: 55, duration: 63, menu: "Bolo, salgados e docinhos", 
  alcoholic_beverages: false, decoration: true, valet: false, insider: true, outsider: false, user: user)

event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_cha1.jpg')), filename: 'buffet_cha1.jpg')
sleep(0.1)
event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_cha2.jpg')), filename: 'buffet_cha2.jpg')
sleep(0.1)

extra_service = ExtraService.new(valet:true)

order = Order.create!(seed:true , user: visitante3, event_type: event, buffet_registration: buffet_registration, date: 10.day.ago, 
                      amount_of_people: 30, duration: 88, inside_the_buffet: true, extra_service: extra_service,
        final_value: 4550, justification_final_value: "Imposto + Taxa de servico", expiration_date: 10.day.ago, payment_method: "pix")
order.waiting_for_client_review!
order.canceled!

extra_service = ExtraService.new(valet:true)

order = Order.create!(seed:true , user: visitante3, event_type: event, buffet_registration: buffet_registration, date: 5.day.ago, 
                      amount_of_people: 35, duration: 77, inside_the_buffet: true, extra_service: extra_service,
        final_value: 505, justification_final_value: "Imposto + Feriado", expiration_date: 5.day.ago, payment_method: "pix")
order.waiting_for_client_review!
order.approved!
order.create_evaluation!(score: 5, comment: "Melhor buffet da região")



user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)

payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)

buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
  cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
  neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")

event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
event_value2 = EventValue.create!(base_price: 99, price_per_person: 65, overtime_rate: 370)

event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
  minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)

event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_casamento1.jpeg')), filename: 'buffet_casamento1.jpeg')
sleep(0.1)
event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_casamento2.jpeg')), filename: 'buffet_casamento2.jpeg')
sleep(0.1)


extra_service = ExtraService.new(alcoholic_beverages: true)

order = Order.create!(user: visitante1, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
                      final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.from_now, payment_method: "pix")
order.waiting_for_client_review!



event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Aniversário", description: "Aniversários Feliz",
  minimum_quantity: 30, maximum_quantity: 995, duration: 180, menu: "Bolo de morango, docinhos e salgadinhos", 
  alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)

event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_aniversario1.jpeg')), filename: 'buffet_aniversario1.jpeg')


extra_service = ExtraService.new(alcoholic_beverages: true)

customer_address = CustomerAddress.create!(public_place: "Alameda Chile", address_number: "69", 
neighborhood: "Jardim Europa", state: "AC", city: "Rio Branco", zip: "69915485", complement: "")

order = Order.create!(user: visitante1, event_type: event, buffet_registration: buffet_registration, date: 1.day.from_now, 
                      amount_of_people: 504, duration: 35, inside_the_buffet: false, extra_service: extra_service,
                      customer_address: customer_address)


event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Formatura", description: "Formatura muito massa",
  minimum_quantity: 10, maximum_quantity: 445, duration: 180, menu: "Bolo, salgado e muito doce", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_formatura.jpeg')), filename: 'buffet_formatura.jpeg')
sleep(0.1)

event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_formatura2.jpeg')), filename: 'buffet_formatura2.jpeg')
sleep(0.1)

extra_service = ExtraService.new(decoration: true)

order = Order.create!(seed:true , user: visitante1, event_type: event, buffet_registration: buffet_registration, date: 1.day.ago, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
        final_value: 55, justification_final_value: "Imposto", expiration_date: 1.day.ago, payment_method: "pix")
order.waiting_for_client_review!
order.approved!
order.create_evaluation!(score: 1, comment: "Muito caro para o que é servido")
order.evaluation.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'CarnePeixe.jpg')), filename: 'CarnePeixe.jpg')
sleep(0.1)

extra_service = ExtraService.new(decoration: true, valet:true)

order = Order.create!(seed:true , user: visitante2, event_type: event, buffet_registration: buffet_registration, date: 2.day.ago, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
        final_value: 55, justification_final_value: "Imposto", expiration_date: 2.day.ago, payment_method: "bitcoin")
order.waiting_for_client_review!
order.approved!
order.create_evaluation!(score: 4, comment: "Ótimo Serviço, poderia melhorar o tempero")
order.evaluation.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'comida diferenciada.jpg')), filename: 'comida diferenciada.jpg')
sleep(0.1)

extra_service = ExtraService.new(decoration: true, valet:true)

order = Order.create!(seed:true , user: visitante3, event_type: event, buffet_registration: buffet_registration, date: 2.day.ago, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
        final_value: 55, justification_final_value: "Imposto", expiration_date: 2.day.ago, payment_method: "bitcoin")
order.waiting_for_client_review!
order.approved!
order.create_evaluation!(score: 3)

extra_service = ExtraService.new(valet:true)

order = Order.create!(seed:true , user: visitante3, event_type: event, buffet_registration: buffet_registration, date: 5.day.ago, 
                      amount_of_people: 54, duration: 35, inside_the_buffet: true, extra_service: extra_service,
        final_value: 55, justification_final_value: "Imposto", expiration_date: 5.day.ago, payment_method: "bitcoin")
order.waiting_for_client_review!
order.approved!
order.create_evaluation!(score: 4)



user = User.create!(name: "Nanda", last_name: "Fernanda", email: 'Nanda@teste.com', password: 'teste123', company: true)

payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true, credit_card: true, debit_card: true)

buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet Alegre', company_name: 'Alegria Buffet', 
  cnpj: "96901808000119", phone: "7995876812", email: 'Nanda@teste.com', public_place: "Quadra 1406 Sul Alameda 7", address_number: "36",
  neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77025-195", complement: "Próximo ao clube do sargento", description: "O buffet mais alegre da região")

event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
event_value2 = EventValue.create!(base_price: 99, price_per_person: 65, overtime_rate: 370)

event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Casamento", description: "Super casamento para jovens casais ",
  minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user)

event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_casamento3.jpeg')), filename: 'buffet_formatura3.jpeg')
sleep(0.1)
event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_casamento4.jpg')), filename: 'buffet_casamento4.jpg')
sleep(0.1)

event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Aleatório", description: "Serviço para qualquer festejo aleatório",
  minimum_quantity: 30, maximum_quantity: 777, duration: 360, menu: "Tudo o que você imaginar", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Formatura", description: "Formatura legal demais",
  minimum_quantity: 44, maximum_quantity: 224, duration: 33, menu: "Salgados e muito bolo", 
  alcoholic_beverages: false, decoration: false, valet: false, insider: true, outsider: false, user: user)

event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffet_formatura3.jpeg')), filename: 'buffet_formatura3.jpeg')
sleep(0.1)






user = User.create!(name: "Otavio", last_name: "Rodrigues", email: 'Otavio@teste.com', password: 'teste123', company: true)

payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true, credit_card: true, debit_card: true)

buffet_registration = BuffetRegistration.create!(available: :desactive, user: user, payment_method: payment_method, trading_name: 'Buffet do Otavio', company_name: 'Otavio Buffet', 
  cnpj: "96901808309119", phone: "7995876812", email: 'Otavio@teste.com', public_place: "Rua dos Açores", address_number: "45",
  neighborhood: "Jardim Campo Alto", state: "MS", city: "Campo Grande", zip: "77025-195", complement: "", description: "O buffet mais sério da região")

event_value = EventValue.create!(base_price: 503, price_per_person: 3544, overtime_rate: 745)
event_value2 = EventValue.create!(base_price: 100, price_per_person: 78, overtime_rate: 6668)

event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Aleatório", description: "Serviço para qualquer festejo aleatório",
  minimum_quantity: 30, maximum_quantity: 777, duration: 360, menu: "Tudo o que você imaginar", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)





user = User.create!(name: "Marcia", last_name: "Almeida", email: 'Almeida@teste.com', password: 'teste123', company: true)



  
user = User.create!(name: "Sofia", last_name: "Silva", email: 'Sofia@teste.com', password: 'teste123', company: true)

payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true, credit_card: true, debit_card: true)

buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet Animado', company_name: 'Animado Buffet', 
  cnpj: "96901408300119", phone: "7995876812", email: 'Sofia@teste.com', public_place: "Rua São Cristovão", address_number: "22",
  neighborhood: "Ipioca", state: "AL", city: "Maceió", zip: "57039838", complement: "Próximo ao supermercado", description: "O buffet mais animado da região")

event_value = EventValue.create!(base_price: 503, price_per_person: 3544, overtime_rate: 745)
event_value2 = EventValue.create!(base_price: 100, price_per_person: 78, overtime_rate: 6668)

event = EventType.create!(status: :desactive, different_weekend: true , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Amazonico", description: "Buffet com Toque amazonico",
  minimum_quantity: 30, maximum_quantity: 65, duration: 360, menu: "Tipicos do amazonas, pratos sigilosos", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Pirata", description: "Serviço com tema pirateado",
  minimum_quantity: 30, maximum_quantity: 777, duration: 360, menu: "Salmão, lula, piranha, e muito mais", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'buffetpirata.jpg')), filename: 'buffetpirata.jpg')
sleep(0.1)
event.images.attach(io: File.open(Rails.root.join('db', 'imgs', 'pirata2.jpeg')), filename: 'pirata2.jpeg')
sleep(0.1)
  
user = User.create!(name: "Matheus", last_name: "Silva", email: 'MatheusSilva@teste.com', password: 'teste123', company: true)

payment_method = PaymentMethod.create!(pix: true, debit_card: true)

buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet dos Residentes', company_name: 'Residentes Buffet', 
  cnpj: "96901828300119", phone: "7995876812", email: 'Otavio@teste.com', public_place: "Travessa Vila Rica A", address_number: "36",
  neighborhood: "Tabuleiro do Martins", state: "AL", city: "Maceió", zip: "77025-195", complement: "Próximo ao clube do sargento", description: "O melhor buffet dos moradores")
  