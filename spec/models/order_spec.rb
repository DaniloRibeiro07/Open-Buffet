require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do 

    it 'Deve haver um código de 8 digitos' do 
      order = Order.new
      order.valid?

      result = order.errors.full_messages.include? "Código não pode ficar em branco"
      expect(result).to eq false 
      expect(order.code.length).to eq 8 
    end

    it 'Duração do evento obrigatória' do
      order = Order.new
      order.valid?

      result = order.errors.full_messages.include? "Duração do Evento (minutos) não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'Duração deve ser maior que 1 minuto' do
      order = Order.new(duration:0 )
      order.valid?

      result = order.errors.full_messages.include? "Duração do Evento (minutos) deve ser maior que 1"
      expect(result).to eq true 
    end

    it 'A data deve ser obrigatória' do
      order = Order.new
      order.valid?

      result = order.errors.full_messages.include? "Data não pode ficar em branco"
      expect(result).to eq true 
    end

    it 'A data deve ser maior do que hoje' do
      order = Order.new(date: Date.current)
      order.valid?

      result = order.errors.full_messages.include? "Data deve ser maior do que hoje (#{I18n.l Date.current})"
      expect(result).to eq true 
    end

    it 'A data deve ser maior do que hoje - 2 ' do
      order = Order.new(date: 1.day.ago)
      order.valid?

      result = order.errors.full_messages.include? "Data deve ser maior do que hoje (#{I18n.l Date.current})"
      expect(result).to eq true 
    end

    it 'A data deve ser maior do que hoje' do
      order = Order.new(date: 1.day.from_now)
      order.valid?

      result = order.errors.full_messages.include? "Data deve ser maior do que hoje (#{I18n.l Date.current})"
      expect(result).to eq false 
    end

    it 'deve haver um buffet' do 
      order = Order.new(buffet_registration: nil)
      order.valid?

      result = order.errors.full_messages.include? "Registro de um buffet é obrigatório(a)"
      expect(result).to eq true 
    end

    it 'deve haver um tipo de evento' do 
      order = Order.new(event_type: nil)
      order.valid?

      result = order.errors.full_messages.include? "Tipo de Evento é obrigatório(a)"
      expect(result).to eq true 
    end

    it 'Dentro do buffet ? obrigatório' do 
      order = Order.new(inside_the_buffet: nil)
      order.valid?

      result = order.errors.full_messages.include? "Dentro do Buffet? não está incluído na lista"
      expect(result).to eq true 
    end

    it 'Dentro do buffet ? pode ser falso' do 
      order = Order.new(inside_the_buffet: false)
      order.valid?

      result = order.errors.full_messages.include? "Dentro do Buffet? não está incluído na lista"
      expect(result).to eq false 
    end

    it 'Dentro do buffet ? pode ser true' do 
      order = Order.new(inside_the_buffet: true)
      order.valid?

      result = order.errors.full_messages.include? "Dentro do Buffet? não está incluído na lista"
      expect(result).to eq false 
    end


    it 'Quantidade de pessoas deve ser menor ou igual do que a quantidade máxima do evento' do
      event = EventType.new(maximum_quantity: 100)
      order = Order.new(event_type: event, amount_of_people: 101)
      order.valid? 
      result = order.errors.full_messages.include? "Participantes do Evento Deve ser menor ou igual a 100"
      expect(result).to eq true
    end

    it 'Quantidade de pessoas deve ser maior ou igual do que a quantidade mínima do evento' do
      event = EventType.new(minimum_quantity: 10)
      order = Order.new(event_type: event, amount_of_people: 9)
      order.valid? 
      result = order.errors.full_messages.include? "Participantes do Evento Deve ser maior ou igual a 10"
      expect(result).to eq true
    end

    it 'O endereço do cliente deve ser especificado se o evento não for dentro do buffet' do
      order = Order.new(inside_the_buffet: false) 
      order.valid? 
      result = order.errors.full_messages.include? "Endereço do cliente obrigatório"
      expect(result).to eq true 
    end

    it 'O endereço do cliente não é necessário se o evento for dentro do buffet' do
      order = Order.new(inside_the_buffet: true) 
      order.valid? 
      result = order.errors.full_messages.include? "Endereço do cliente obrigatório"
      expect(result).to eq false 
    end

    it 'O attributo user precisa ser um cliente' do
      user = User.new(company: true)
      order = Order.new(user: user) 
      order.valid? 
      result = order.errors.full_messages.include? "Usuário precisa ser um cliente"
      expect(result).to eq true 
    end
    
  end
end
