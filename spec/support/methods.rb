def create_user_payment_buffet_event_value
  user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
  payment_method = PaymentMethod.create!(pix: true)
  buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
    cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
    state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira")
  event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)
  
  [user, payment_method, buffet_registration, event_value]
end