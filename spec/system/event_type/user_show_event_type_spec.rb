require 'rails_helper'

describe "Usuárioa acessa a página de detalhes do evento" do
  it 'Vê a página sendo o Dono do Buffet' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)
  
    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working,buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
      minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
      alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)

    event.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario.jpeg')), filename: 'festa_de_aniversario.jpeg')
    event.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario2.jpg')), filename: 'festa_de_aniversario2.jpg')
  
    login_as user
    visit root_path
    click_on "Meu Buffet"
    click_on "Aniversário"

    expect(page).to have_button "Pesquisar"
    expect(page).to have_content "Evento associado ao Buffet: Buffet da familia" 
    expect(page).to have_content "Nome do Evento: Aniversário" 
    expect(page).to have_content "Descrição do Evento: Super aniversário para a sua familia e amigos" 
    expect(page).to have_content "Quantidade Mínima de participantes: 10" 
    expect(page).to have_content "Quantidade Máxima de participantes: 15"  
    expect(page).to have_content "Duração do evento em minutos: 60" 
    expect(page).to have_content "Cardápio: Bolo de aniversário, coxinha e salgados"
    expect(page).to have_content "O Evento pode conter bebidas alcoólicas: Não" 
    expect(page).to have_content "O Evento pode conter Decorações: Sim" 
    expect(page).to have_content "O Evento pode conter serviço de estacionamento/valet: Sim" 
    expect(page).to have_content "O evento pode ser dentro do buffet: Não" 
    expect(page).to have_content "O evento pode ser à domicilio: Sim" 
    expect(page).to have_content "Imagens:"
    expect(page).not_to have_content "Não há nenhuma imagem cadastrada"  
    expect(page).to have_css('img[src*="festa_de_aniversario.jpeg"]')
    expect(page).to have_css('img[src*="festa_de_aniversario2.jpg"]')
    expect(page).to have_content "Editar Informações do Evento"
    expect(page).not_to have_content "Fazer um pedido" 
    expect(page).to have_button "Voltar" 
  end

  it 'Vê a página sendo Dono de outro buffet' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)
  
    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working,buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
      minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
      alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)
    
    other_user = User.create!(name: "Ana", last_name: "Maria", email: 'ana@teste.com', password: 'teste123', company: true)

    buffet_registration2 = BuffetRegistration.create!(trading_name: 'Buffet da Avon', company_name: 'Carla Buffet', 
    cnpj: "5757869", phone: "456789312", email: 'carla@teste.com', public_place: "Rua dos perfumes", address_number: "33", neighborhood: "São Jorge", 
    state: "BA", city: "Salvador", zip: "578964-621", complement: "Longe", description: "O melhor buffet das perfumarias", 
    payment_method: payment_method, user: other_user)

    event.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario.jpeg')), filename: 'festa_de_aniversario.jpeg')
    event.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario2.jpg')), filename: 'festa_de_aniversario2.jpg')

    login_as other_user
    visit root_path
    click_on "Buffet da familia"
    click_on "Aniversário"

    expect(page).to have_content "Evento associado ao Buffet: Buffet da familia" 
    expect(page).to have_content "Nome do Evento: Aniversário" 
    expect(page).to have_content "Descrição do Evento: Super aniversário para a sua familia e amigos" 
    expect(page).to have_content "Quantidade Mínima de participantes: 10" 
    expect(page).to have_content "Quantidade Máxima de participantes: 15"  
    expect(page).to have_content "Duração do evento em minutos: 60" 
    expect(page).to have_content "Cardápio: Bolo de aniversário, coxinha e salgados"
    expect(page).to have_content "O Evento pode conter bebidas alcoólicas: Não" 
    expect(page).to have_content "O Evento pode conter Decorações: Sim" 
    expect(page).to have_content "O Evento pode conter serviço de estacionamento/valet: Sim" 
    expect(page).to have_content "O evento pode ser dentro do buffet: Não" 
    expect(page).to have_content "O evento pode ser à domicilio: Sim" 
    expect(page).not_to have_content "Não há nenhuma imagem cadastrada"  
    expect(page).to have_css('img[src*="festa_de_aniversario.jpeg"]')
    expect(page).to have_css('img[src*="festa_de_aniversario2.jpg"]')
    expect(page).not_to have_content "Editar Informações do Evento"
    expect(page).not_to have_content "Fazer um pedido" 
    expect(page).to have_button "Voltar" 
  end

  it 'Vê a página sendo o um visitante' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)
  
    EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working,
      buffet_registration: buffet_registration, name: "Formatura", description: "O melhor serviço de buffet para sua formatura",
      minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Surpresa", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: false, outsider: true, user: user)

    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working,
      buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
      minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
      alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)
  
    visit root_path
    click_on "Buffet da familia"
    click_on "Formatura"

    expect(page).to have_content "Evento associado ao Buffet: Buffet da familia" 
    expect(page).to have_content "Nome do Evento: Formatura" 
    expect(page).to have_content "Descrição do Evento: O melhor serviço de buffet para sua formatura" 
    expect(page).to have_content "Quantidade Mínima de participantes: 10" 
    expect(page).to have_content "Quantidade Máxima de participantes: 15"  
    expect(page).to have_content "Duração do evento em minutos: 60" 
    expect(page).to have_content "Cardápio: Surpresa"
    expect(page).to have_content "O Evento pode conter bebidas alcoólicas: Sim" 
    expect(page).to have_content "O Evento pode conter Decorações: Sim" 
    expect(page).to have_content "O Evento pode conter serviço de estacionamento/valet: Sim" 
    expect(page).to have_content "O evento pode ser dentro do buffet: Não" 
    expect(page).to have_content "O evento pode ser à domicilio: Sim" 
    expect(page).to have_content "Não há nenhuma imagem cadastrada"  
    expect(page).not_to have_content "Editar Informações do Evento"
    expect(page).to have_button "Fazer um pedido"
    expect(page).to have_button "Voltar" 
  end

  it 'Vê a página sendo um cliente' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)

    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)
  
    EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working,
      buffet_registration: buffet_registration, name: "Formatura", description: "O melhor serviço de buffet para sua formatura",
      minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Surpresa", 
      alcoholic_beverages: true, decoration: true, valet: true, insider: false, outsider: true, user: user)

    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working,
      buffet_registration: buffet_registration, name: "Aniversário", description: "Super aniversário para a sua familia e amigos",
      minimum_quantity: 10, maximum_quantity: 15, duration: 60, menu: "Bolo de aniversário, coxinha e salgados", 
      alcoholic_beverages: false, decoration: true, valet: true, insider: false, outsider: true, user: user)

    event.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario2.jpg')), filename: 'festa_de_aniversario2.jpg')

    visitant = User.new(name: "Marta", last_name: "Almeida", email: 'Marta@teste.com', password: 'teste123', company: false)
    visitant.build_client_datum(cpf: "02241335002")
    visitant.save!

    login_as visitant
    visit root_path
    click_on "Buffet da familia"
    click_on "Aniversário"

    expect(page).to have_content "Evento associado ao Buffet: Buffet da familia" 
    expect(page).to have_content "Nome do Evento: Aniversário" 
    expect(page).to have_content "Descrição do Evento: Super aniversário para a sua familia e amigos" 
    expect(page).to have_content "Quantidade Mínima de participantes: 10" 
    expect(page).to have_content "Quantidade Máxima de participantes: 15"  
    expect(page).to have_content "Duração do evento em minutos: 60" 
    expect(page).to have_content "Cardápio: Bolo de aniversário, coxinha e salgados"
    expect(page).to have_content "O Evento pode conter bebidas alcoólicas: Não" 
    expect(page).to have_content "O Evento pode conter Decorações: Sim" 
    expect(page).to have_content "O Evento pode conter serviço de estacionamento/valet: Sim" 
    expect(page).to have_content "O evento pode ser dentro do buffet: Não" 
    expect(page).to have_content "O evento pode ser à domicilio: Sim" 
    expect(page).not_to have_content "Não há nenhuma imagem cadastrada"  
    expect(page).to have_css('img[src*="festa_de_aniversario2.jpg"]')
    expect(page).not_to have_content "Editar Informações do Evento"
    expect(page).to have_button "Fazer um pedido"
    expect(page).to have_button "Voltar" 
  end
end