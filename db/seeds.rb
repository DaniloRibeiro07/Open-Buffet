# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


visitante = User.create!(name: "Joana", last_name: "Silva", email: 'Joana@teste.com', password: 'teste123', company: false)
visitante.create_client_datum!(cpf: "02241335002")

visitante = User.create!(name: "Sabrina", last_name: "Juan", email: 'Sabrina@teste.com', password: 'teste123', company: false)
visitante.create_client_datum!(cpf: "97498970058")


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

event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Aniversário", description: "Aniversários Feliz",
  minimum_quantity: 30, maximum_quantity: 995, duration: 180, menu: "Bolo de morango, docinhos e salgadinhos", 
  alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)

event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Formatura", description: "Formatura muito massa",
  minimum_quantity: 10, maximum_quantity: 445, duration: 180, menu: "Bolo, salgado e muito doce", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)





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

event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Aleatório", description: "Serviço para qualquer festejo aleatório",
  minimum_quantity: 30, maximum_quantity: 777, duration: 360, menu: "Tudo o que você imaginar", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)

event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value2,
  buffet_registration: buffet_registration, name: "Formatura", description: "Formatura legal demais",
  minimum_quantity: 44, maximum_quantity: 224, duration: 33, menu: "Salgados e muito bolo", 
  alcoholic_beverages: false, decoration: false, valet: false, insider: true, outsider: false, user: user)
