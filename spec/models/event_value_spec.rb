require 'rails_helper'

RSpec.describe EventValue, type: :model do
  describe "#valid" do 
    it "Cadastro correto" do 
      event_value = EventValue.new(base_price: 50.39, price_per_person: 30)
      
      expect(event_value.valid?).to eq true
    end

    it "Preço base obrigatório" do 
      event_value = EventValue.new(price_per_person: 30)
      
      expect(event_value.valid?).to eq false
    end

    it "Preço por pessoa obrigatório" do 
      event_value = EventValue.new(base_price: 50.39)
      
      expect(event_value.valid?).to eq false
    end
  end
end
