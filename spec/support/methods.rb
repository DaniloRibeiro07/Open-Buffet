def create_user_payment_buffet_event_value
  user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
  payment_method = PaymentMethod.create!(pix: true)
  buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
    cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
    state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira")
  event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
  [user, payment_method, buffet_registration, event_value]
end

def create_users_buffets_events 
  user1, payment_method, buffet_registration1,  event_value, = create_user_payment_buffet_event_value

  event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
  buffet_registration: buffet_registration1, name: "Casamento", description: "Super casamento para jovens casais ",
  minimum_quantity: 30, maximum_quantity: 100, duration: 60, menu: "Bolo, bebidas, crustáceos, e o que o casal desejar", 
  alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: true, user: user1)

  user2 = User.create!(name: "Carla", last_name: "Farias", email: 'carla@teste.com', password: 'teste123', company: true)

  buffet_registration2 = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
      cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
      state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
      payment_method: payment_method, user: user2)

  other_event = EventType.create!(different_weekend: true ,weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration2, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
      minimum_quantity: 10, maximum_quantity: 50, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
      alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user2)

  event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
    buffet_registration: buffet_registration2, name: "Formatura", description: "Formatura insana para universitários",
    minimum_quantity: 50, maximum_quantity: 200, duration: 180, menu: "Salgados, Crustáceos, Tortas, e o que os universitários quiser", 
    alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)
end