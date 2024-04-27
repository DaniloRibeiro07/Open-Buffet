require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe "#valid" do 
    it "Deve haver uma forma de pagamento" do 
      payment_method = PaymentMethod.new
      
      expect(payment_method.valid?).to eq false 
    end

    it "Pagamento apenas com PIX" do 
      payment_method = PaymentMethod.new(pix: true)
      
      expect(payment_method.valid?).to eq true 
    end

    it "Pagamento apenas com boleto" do 
      payment_method = PaymentMethod.new(boleto: true)
      
      expect(payment_method.valid?).to eq true 
    end

    it "Pagamento apenas com Cartão de crédito" do 
      payment_method = PaymentMethod.new(credit_card: true)
      
      expect(payment_method.valid?).to eq true 
    end

    it "Pagamento apenas com Cartão de debito" do 
      payment_method = PaymentMethod.new(debit_card: true)
      
      expect(payment_method.valid?).to eq true 
    end
    
    it "Pagamento apenas com dinheiro" do 
      payment_method = PaymentMethod.new(money: true)
      
      expect(payment_method.valid?).to eq true 
    end

    it "Pagamento apenas com bitcoin" do 
      payment_method = PaymentMethod.new(bitcoin: true)
      
      expect(payment_method.valid?).to eq true 
    end

    it "Pagamento apenas com transferência bancâria" do 
      payment_method = PaymentMethod.new(bank_transfer: true)
      
      expect(payment_method.valid?).to eq true 
    end

    it "Pagamento com mais de um método" do 
      payment_method = PaymentMethod.new(bank_transfer: true, pix: true, money: true, bitcoin: true)
      
      expect(payment_method.valid?).to eq true 
    end
  end


end
