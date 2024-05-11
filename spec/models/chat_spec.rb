require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe '#valid' do 
    it "A mensagem é obrigatória" do
      chat = Chat.new(message: nil)
      chat.valid?
      result = chat.errors.full_messages.include? "Message não pode ficar em branco"
      expect(result).to eq true
    end

    it "Para a empresa pode ser true ou falso" do
      chat = Chat.new(to_company: nil)
      chat.valid?
      result = chat.errors.full_messages.include? "To company não está incluído na lista"
      expect(result).to eq true
    end

    it "Para a empresa pode ser true ou falso" do
      chat = Chat.new(to_company: true)
      chat.valid?
      result = chat.errors.full_messages.include? "To company não está incluído na lista"
      expect(result).to eq false
    end

    it "Para a empresa pode ser true ou falso" do
      chat = Chat.new(to_company: false)
      chat.valid?
      result = chat.errors.full_messages.include? "To company não está incluído na lista"
      expect(result).to eq false
    end


  end
end
