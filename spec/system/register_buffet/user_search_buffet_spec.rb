require 'rails_helper'

describe "Usuário faz uma busca de um buffet" do
  it 'Busca por nome de um buffet' do
    user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(pix: true)
    
    buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
      neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
    
    user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)
  
    payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)
      
    buffet_registration2 = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")
      
    visit root_path 

    fill_in "search",	with: "Familia"
    click_on "Pesquisar"

    expect(page).to have_button "Pesquisar"
    expect(page).to have_link "Buffet da familia", href: buffet_registration_path(buffet_registration)
    expect(page).to have_content "1 Buffet Cadastrado"
    expect(page).to have_content "Cidade: Palmas"
    expect(page).to have_content "Estado: TO"
    expect(page).to have_button "Voltar" 
  end

  it 'Busca por nome de um evento ' do
    user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(pix: true)
    
    buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
      neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")
    
    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration, name: "Formatura", description: "Formatura de Jovens do Ensino Médio",
      minimum_quantity: 10, maximum_quantity: 999, duration: 445, menu: "Bolo da chiquinha e do seu madruga", 
      alcoholic_beverages: false, decoration: true, valet: false, insider: true, outsider: false, user: user)


    user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)
  
    payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)
      
    buffet_registration2 = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")
      
    event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration2, name: "Formatura", description: "Formatura muito massa",
        minimum_quantity: 10, maximum_quantity: 445, duration: 180, menu: "Bolo, salgado e muito doce", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user)
    
    
    visit root_path 

    fill_in "search",	with: "Formatura"
    click_on "Pesquisar"

    expect(page).to have_button "Pesquisar"
    expect(page).to have_content "2 Buffet Cadastrados"
    expect(page).to have_link "Buffet da Avon", href: buffet_registration_path(buffet_registration2)
    expect(page).to have_content "Cidade: São Gonçalo"
    expect(page).to have_content "Estado: RJ"
    expect(page).to have_link "Buffet da familia", href: buffet_registration_path(buffet_registration)
    expect(page).to have_content "Cidade: Palmas"
    expect(page).to have_content "Estado: TO"
  end

  it 'Busca por um evento desabilitado ' do

    user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)
  
    payment_method = PaymentMethod.create!(pix: true, boleto: true, bitcoin: true)

    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

      
    buffet_registration2 = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")
      
    event = EventType.create!(different_weekend: false , weekend_price: event_value, working_day_price: event_value,
        buffet_registration: buffet_registration2, name: "Formatura", description: "Formatura muito massa",
        minimum_quantity: 10, maximum_quantity: 445, duration: 180, menu: "Bolo, salgado e muito doce", 
        alcoholic_beverages: true, decoration: true, valet: true, insider: true, outsider: false, user: user, status: :desactive)
    
    
    visit root_path 

    fill_in "search",	with: "Formatura"
    click_on "Pesquisar"

    expect(page).to have_button "Pesquisar"
    expect(page).to have_content "Não há Buffets Cadastrados"
    expect(page).not_to have_link "Buffet da Avon", href: buffet_registration_path(buffet_registration2)
  end

  it 'Busca por uma cidade' do
    user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(pix: true)
    
    buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
      neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

    user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)
        
    buffet_registration2 = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")
      
    user = User.create!(name: "Nanda", last_name: "Fernanda", email: 'Nanda@teste.com', password: 'teste123', company: true)
        
    buffet_registration3 = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet Alegre', company_name: 'Alegria Buffet', 
          cnpj: "96901808000119", phone: "7995876812", email: 'Nanda@teste.com', public_place: "Quadra 1406 Sul Alameda 7", address_number: "36",
          neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77025-195", complement: "Próximo ao clube do sargento", description: "O buffet mais alegre da região")
        
    
    visit root_path 

    fill_in "search",	with: "Palmas"
    click_on "Pesquisar"

    expect(page).to have_button "Pesquisar"
    expect(page).to have_content "2 Buffet Cadastrados"
    expect(page).to have_link "Buffet Alegre", href: buffet_registration_path(buffet_registration3)
    expect(page).to have_content "Cidade: Palmas"
    expect(page).to have_content "Estado: TO"
    expect(page).to have_link "Buffet da familia", href: buffet_registration_path(buffet_registration)
    expect(page).to have_content "Cidade: Palmas"
    expect(page).to have_content "Estado: TO"
  end

  it 'Busca usando um termo incompleto' do
    user = User.create!(name: "Alecrim", last_name: "Farias", email: 'Alecrim@teste.com', password: 'teste123', company: true)

    payment_method = PaymentMethod.create!(pix: true)
    
    buffet_registration = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "17924491000160", phone: "7995876812", email: 'Maria@teste.com', public_place: "Quadra 1112 Sul Alameda 5", address_number: "25A", 
      neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77024-171", complement: "", description: "O melhor buffet das perfumaras")

    user = User.create!(name: "Marcola", last_name: "Francis", email: 'Marcola@teste.com', password: 'teste123', company: true)
        
    buffet_registration2 = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet da Avon', company_name: 'Avon Buffet', 
        cnpj: "87088795000110", phone: "7995876812", email: 'Marcola@teste.com', public_place: "Avenida Joaquim de Oliveira", address_number: "65",
        neighborhood: "Boa Vista", state: "RJ", city: "São Gonçalo", zip: "24466-142", complement: "Próximo ao supermercado", description: "O melhor buffet das perfumaras")
      
    user = User.create!(name: "Nanda", last_name: "Fernanda", email: 'Nanda@teste.com', password: 'teste123', company: true)
        
    buffet_registration3 = BuffetRegistration.create!(user: user, payment_method: payment_method, trading_name: 'Buffet Alegre', company_name: 'Alegria Buffet', 
      cnpj: "96901808000119", phone: "7995876812", email: 'Nanda@teste.com', public_place: "Quadra 1406 Sul Alameda 7", address_number: "36",
      neighborhood: "Plano Diretor Sul", state: "TO", city: "Palmas", zip: "77025-195", complement: "Próximo ao clube do sargento", description: "O buffet mais alegre da região")
    
    event_value = EventValue.create!(base_price: 50.39, price_per_person: 30, overtime_rate: 30)

    event = EventType.create!(different_weekend: true , weekend_price: event_value, working_day_price: event_value,
      buffet_registration: buffet_registration3, name: "Famosa Festa", description: "A festa famosa que a galera precisa",
      minimum_quantity: 10, maximum_quantity: 443, duration: 223, menu: "Churrasco de mais", 
      alcoholic_beverages: true, decoration: true, valet: false, insider: true, outsider: false, user: user)
        
    
    visit root_path 

    fill_in "search",	with: "Fam"
    click_on "Pesquisar"

    expect(page).to have_button "Pesquisar"
    expect(page).to have_content "2 Buffet Cadastrados"
    expect(page).to have_link "Buffet Alegre", href: buffet_registration_path(buffet_registration3)
    expect(page).to have_content "Cidade: Palmas"
    expect(page).to have_content "Estado: TO"
    expect(page).to have_link "Buffet da familia", href: buffet_registration_path(buffet_registration)
    expect(page).to have_content "Cidade: Palmas"
    expect(page).to have_content "Estado: TO"
  end
end