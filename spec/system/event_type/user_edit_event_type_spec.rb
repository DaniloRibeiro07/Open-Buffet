require 'rails_helper'

describe "Usuário acessa a página de editar evento",  driver: :selenium_chrome, js: true  do
  it 'Vê a página' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)

    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)

    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working, buffet_registration: buffet_registration, 
      name: "Aniversário", description: "Super aniversário para a sua familia e amigos", minimum_quantity: 10, maximum_quantity: 15, 
      duration: 60, menu: "Bolo de aniversário, coxinha e salgados", alcoholic_beverages: false, decoration: true, valet: true, 
      insider: false, outsider: true, user: user)

    event.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario.jpeg')), filename: 'festa_de_aniversario.jpeg')
    event.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario2.jpg')), filename: 'festa_de_aniversario2.jpg')

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Aniversário"
    click_on "Editar Informações do Evento"

    expect(page).not_to have_button "Pesquisar"
    expect(page).to have_content "Editando Evento em Buffet da familia" 
    expect(page).to have_field "Nome do Evento", with:  "Aniversário" 
    expect(page).to have_field "Descrição do Evento", with: "Super aniversário para a sua familia e amigos"
    expect(page).to have_field "Quantidade Mínima de Pessoas", with: "10"
    expect(page).to have_field "Quantidade Máxima de Pessoas", with: "15"
    expect(page).to have_field "Duração em minutos", with: "60" 
    expect(page).to have_field "Cardápio", with:  "Bolo de aniversário, coxinha e salgados"
    expect(page).to have_unchecked_field "Bebida Alcoólica" 
    expect(page).to have_checked_field "Decoração" 
    expect(page).to have_checked_field "Serviço de Estacionamento/Valet" 
    expect(page).to have_unchecked_field "Evento dentro do Buffet" 
    expect(page).to have_checked_field "Evento à domicílio" 
    expect(find('#event_type_working_day_price_attributes_base_price').value).to eq '10.0'
    expect(find('#event_type_working_day_price_attributes_price_per_person').value).to eq '67.0'
    expect(find('#event_type_working_day_price_attributes_overtime_rate').value).to eq '44.0'
    expect(page).to have_checked_field "Valor Diferente aos Finais de Semana" 
    expect(find('#event_type_weekend_price_attributes_base_price').value).to eq '50.39'
    expect(find('#event_type_weekend_price_attributes_price_per_person').value).to eq '30.25'
    expect(find('#event_type_weekend_price_attributes_overtime_rate').value).to eq '30.99'
    expect(page).to have_content "Imagens inseridas:"
    expect(page).to have_css('img[src*="festa_de_aniversario.jpeg"]')
    expect(page).to have_button("Remover Imagem-1")
    expect(page).to have_css('img[src*="festa_de_aniversario2.jpg"]')
    expect(page).to have_button("Remover Imagem-2")
    expect(page).to have_button "Salvar"
    expect(page).to have_button "Deletar Evento"
    expect(page).to have_button "Voltar" 
  end

  it 'Atualiza a descrição e quantidade' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@te2ste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "956874951213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)

    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working, buffet_registration: buffet_registration, 
      name: "Aniversário", description: "Super aniversário para a sua familia e amigos", minimum_quantity: 10, maximum_quantity: 15, 
      duration: 60, menu: "Bolo de aniversário, coxinha e salgados", alcoholic_beverages: false, decoration: true, valet: true, 
      insider: false, outsider: true, user: user)

    event.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario.jpeg')), filename: 'festa_de_aniversario.jpeg')
    event.images.attach(io: File.open(Rails.root.join('spec', 'support', 'imgs', 'festa_de_aniversario2.jpg')), filename: 'festa_de_aniversario2.jpg')
  
    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Aniversário"
    click_on "Editar Informações do Evento"

    fill_in "Descrição do Evento",	with: "Aniversário de principe e princesa, pelo melhor preço" 
    fill_in "Quantidade Máxima de Pessoas",	with: "50" 
    check "Evento dentro do Buffet"

    within "#div-0" do 
      click_on "Remover Imagem"
    end


    click_on "Salvar"

    expect(current_path).to eq  event_type_path(event.id)
    expect(page).to have_content "Evento associado ao Buffet: Buffet da familia" 
    expect(page).to have_content "Nome do Evento: Aniversário" 
    expect(page).to have_content "Descrição do Evento: Aniversário de principe e princesa, pelo melhor preço" 
    expect(page).to have_content "Quantidade Mínima de participantes: 10" 
    expect(page).to have_content "Quantidade Máxima de participantes: 50"  
    expect(page).to have_content "Duração do evento em minutos: 60" 
    expect(page).to have_content "Cardápio: Bolo de aniversário, coxinha e salgados"
    expect(page).to have_content "O Evento pode conter bebidas alcoólicas: Não" 
    expect(page).to have_content "O Evento pode conter Decorações: Sim" 
    expect(page).to have_content "O Evento pode conter serviço de estacionamento/valet: Sim" 
    expect(page).to have_content "O evento pode ser dentro do buffet: Sim" 
    expect(page).to have_content "O evento pode ser à domicilio: Sim" 
    expect(page).to have_content "Preço base em dia útil: 10" 
    expect(page).to have_content "Valor por acréscimo de pessoa em dia útil: 67" 
    expect(page).to have_content "Valor da hora extra em dia útil: 44" 
    expect(page).to have_content "Preço base no final de semana: 50.39" 
    expect(page).to have_content "Valor por acréscimo de pessoa no final de semana: 30.25" 
    expect(page).to have_content "Valor da hora extra no final de semana: 30.99" 
    expect(page).not_to have_css('img[src*="festa_de_aniversario.jpeg"]')
    expect(page).to have_css('img[src*="festa_de_aniversario2.jpg"]')
  end

  it 'Algum campo obrigatório fica vazio' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)
  
    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working, buffet_registration: buffet_registration, 
        name: "Aniversário", description: "Super aniversário para a sua familia e amigos", minimum_quantity: 10, maximum_quantity: 15, 
        duration: 60, menu: "Bolo de aniversário, coxinha e salgados", alcoholic_beverages: false, decoration: true, valet: true, 
        insider: false, outsider: true, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Aniversário"
    click_on "Editar Informações do Evento"

    fill_in "Descrição do Evento",	with: "" 
    fill_in "Quantidade Máxima de Pessoas",	with: "" 

    click_on "Salvar"

    expect(page).to have_content "Editando Evento em Buffet da familia" 
    expect(page).to have_content "Descrição do Evento não pode ficar em branco" 
    expect(page).to have_content "Quantidade Máxima de Pessoas não pode ficar em branco" 
    expect(page).to have_field "Nome do Evento", with:  "Aniversário" 
    expect(page).to have_field "Descrição do Evento", with: ""
    expect(page).to have_field "Quantidade Mínima de Pessoas", with: "10"
    expect(page).to have_field "Quantidade Máxima de Pessoas", with: ""
    expect(page).to have_field "Duração em minutos", with: "60" 
    expect(page).to have_field "Cardápio", with:  "Bolo de aniversário, coxinha e salgados"
    expect(page).to have_unchecked_field "Bebida Alcoólica" 
    expect(page).to have_checked_field "Decoração" 
    expect(page).to have_checked_field "Serviço de Estacionamento/Valet" 
    expect(page).to have_unchecked_field "Evento dentro do Buffet" 
    expect(page).to have_checked_field "Evento à domicílio" 
  end

  it 'Aperta em voltar' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)
  
    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working, buffet_registration: buffet_registration, 
        name: "Aniversário", description: "Super aniversário para a sua familia e amigos", minimum_quantity: 10, maximum_quantity: 15, 
        duration: 60, menu: "Bolo de aniversário, coxinha e salgados", alcoholic_beverages: false, decoration: true, valet: true, 
        insider: false, outsider: true, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Aniversário"
    click_on "Editar Informações do Evento"
    click_on "Voltar"

    expect(current_path).to eq event_type_path(event.id)
  end

  it 'Aperta em deletar' do 
    user = User.create!(name: "Maria", last_name: "Farias", email: 'Maria@teste.com', password: 'teste123', company: true)
    payment_method = PaymentMethod.create!(bank_transfer: true, pix: true, money: true, bitcoin: true)
    buffet_registration = BuffetRegistration.create!(trading_name: 'Buffet da familia', company_name: 'Eduarda Buffet', 
      cnpj: "95687495213", phone: "7995876812", email: 'Eduarda@teste.com', public_place: "Rua das flores", address_number: "25A", neighborhood: "São Lucas", 
      state: "SP", city: "São Paulo", zip: "48750-621", complement: "", description: "O melhor buffet da familia brasileira", 
      payment_method: payment_method, user: user)
    event_value_working = EventValue.create!(base_price: 10, price_per_person: 67, overtime_rate: 44)
    event_value_weekend = EventValue.create!(base_price: 50.39, price_per_person: 30.25, overtime_rate: 30.99)
  
    event = EventType.create!(different_weekend: true ,weekend_price: event_value_weekend, working_day_price: event_value_working, buffet_registration: buffet_registration, 
        name: "Aniversário", description: "Super aniversário para a sua familia e amigos", minimum_quantity: 10, maximum_quantity: 15, 
        duration: 60, menu: "Bolo de aniversário, coxinha e salgados", alcoholic_beverages: false, decoration: true, valet: true, 
        insider: false, outsider: true, user: user)

    login_as user

    visit root_path
    click_on "Meu Buffet"
    click_on "Aniversário"
    click_on "Editar Informações do Evento"
    click_on "Deletar Evento"

    expect(current_path).to eq buffet_registration_path(buffet_registration)
    expect(page).to have_content "Evento Deletado com Sucesso"
    expect(page).to have_content "Nenhum evento cadastrado" 
  end
end