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

  describe "#all_available_methods_and_values_to_select" do 
    it 'pix verdadeiro' do 
      payment_method = PaymentMethod.new(pix: true)
      result = payment_method.all_available_methods_and_values_to_select
      expect(result).to eq [{:name=>"pix", :value=>true},
                            {:name=>"boleto", :value=>nil},
                            {:name=>"credit_card", :value=>nil},
                            {:name=>"debit_card", :value=>nil},
                            {:name=>"money", :value=>nil},
                            {:name=>"bitcoin", :value=>nil},
                            {:name=>"bank_transfer", :value=>nil}]
    end

    it 'boleto verdadeiro' do 
      payment_method = PaymentMethod.new(boleto: true)
      result = payment_method.all_available_methods_and_values_to_select
      expect(result).to eq [{:name=>"pix", :value=>nil},
                            {:name=>"boleto", :value=>true},
                            {:name=>"credit_card", :value=>nil},
                            {:name=>"debit_card", :value=>nil},
                            {:name=>"money", :value=>nil},
                            {:name=>"bitcoin", :value=>nil},
                            {:name=>"bank_transfer", :value=>nil}]
    end

    it 'Cartão de crédito verdadeiro' do 
      payment_method = PaymentMethod.new(credit_card: true)
      result = payment_method.all_available_methods_and_values_to_select
      expect(result).to eq [{:name=>"pix", :value=>nil},
                            {:name=>"boleto", :value=>nil},
                            {:name=>"credit_card", :value=>true},
                            {:name=>"debit_card", :value=>nil},
                            {:name=>"money", :value=>nil},
                            {:name=>"bitcoin", :value=>nil},
                            {:name=>"bank_transfer", :value=>nil}]
    end

    it 'cartão de debito verdadeiro' do 
      payment_method = PaymentMethod.new(debit_card: true)
      result = payment_method.all_available_methods_and_values_to_select
      expect(result).to eq [{:name=>"pix", :value=>nil},
                            {:name=>"boleto", :value=>nil},
                            {:name=>"credit_card", :value=>nil},
                            {:name=>"debit_card", :value=>true},
                            {:name=>"money", :value=>nil},
                            {:name=>"bitcoin", :value=>nil},
                            {:name=>"bank_transfer", :value=>nil}]
    end

    it 'Dinheiro verdadeiro' do 
      payment_method = PaymentMethod.new(money: true)
      result = payment_method.all_available_methods_and_values_to_select
      expect(result).to eq [{:name=>"pix", :value=>nil},
                            {:name=>"boleto", :value=>nil},
                            {:name=>"credit_card", :value=>nil},
                            {:name=>"debit_card", :value=>nil},
                            {:name=>"money", :value=>true},
                            {:name=>"bitcoin", :value=>nil},
                            {:name=>"bank_transfer", :value=>nil}]
    end

    it 'Bitcoin verdadeiro' do 
      payment_method = PaymentMethod.new(bitcoin: true)
      result = payment_method.all_available_methods_and_values_to_select
      expect(result).to eq [{:name=>"pix", :value=>nil},
                            {:name=>"boleto", :value=>nil},
                            {:name=>"credit_card", :value=>nil},
                            {:name=>"debit_card", :value=>nil},
                            {:name=>"money", :value=>nil},
                            {:name=>"bitcoin", :value=>true},
                            {:name=>"bank_transfer", :value=>nil}]
    end

    it 'Transferência Bancária verdadeiro' do 
      payment_method = PaymentMethod.new(bank_transfer: true)
      result = payment_method.all_available_methods_and_values_to_select
      expect(result).to eq [{:name=>"pix", :value=>nil},
                            {:name=>"boleto", :value=>nil},
                            {:name=>"credit_card", :value=>nil},
                            {:name=>"debit_card", :value=>nil},
                            {:name=>"money", :value=>nil},
                            {:name=>"bitcoin", :value=>nil},
                            {:name=>"bank_transfer", :value=>true}]
    end

    it 'Todos os metodos verdadeiro' do 
      payment_method = PaymentMethod.new(pix: true, boleto: true, credit_card: true, debit_card: true, money: true,
                                        bitcoin: true, bank_transfer: true)
      result = payment_method.all_available_methods_and_values_to_select
      expect(result).to eq [{:name=>"pix", :value=>true},
                            {:name=>"boleto", :value=>true},
                            {:name=>"credit_card", :value=>true},
                            {:name=>"debit_card", :value=>true},
                            {:name=>"money", :value=>true},
                            {:name=>"bitcoin", :value=>true},
                            {:name=>"bank_transfer", :value=>true}]
    end

    it 'Todos os metodos falso' do 
      payment_method = PaymentMethod.new()
      result = payment_method.all_available_methods_and_values_to_select
      expect(result).to eq [{:name=>"pix", :value=>nil},
                            {:name=>"boleto", :value=>nil},
                            {:name=>"credit_card", :value=>nil},
                            {:name=>"debit_card", :value=>nil},
                            {:name=>"money", :value=>nil},
                            {:name=>"bitcoin", :value=>nil},
                            {:name=>"bank_transfer", :value=>nil}]
    end
  end

  describe "#all_available_methods_to_select" do 
    it 'Resultado esperado' do 
      payment_method = PaymentMethod.new(pix: true)
      result = payment_method.all_available_methods_to_select
      expect(result).to eq  ["pix", "boleto", "credit_card", "debit_card", "money", "bitcoin", "bank_transfer"]
    end
  end

  describe "#available_methods_to_select_translated" do 
    it 'pix verdadeiro' do 
      payment_method = PaymentMethod.new(pix: true)
      result = payment_method.available_methods_to_select_translated
      expect(result).to eq ["PIX"]
    end

    it 'boleto verdadeiro' do 
      payment_method = PaymentMethod.new(boleto: true)
      result = payment_method.available_methods_to_select_translated
      expect(result).to eq ["Boleto"]
    end

    it 'Cartão de crédito verdadeiro' do 
      payment_method = PaymentMethod.new(credit_card: true)
      result = payment_method.available_methods_to_select_translated
      expect(result).to eq ["Cartão de Crédito"]
    end

    it 'cartão de debito verdadeiro' do 
      payment_method = PaymentMethod.new(debit_card: true)
      result = payment_method.available_methods_to_select_translated
      expect(result).to eq ["Cartão de Débito"]
    end

    it 'Dinheiro verdadeiro' do 
      payment_method = PaymentMethod.new(money: true)
      result = payment_method.available_methods_to_select_translated
      expect(result).to eq ["Dinheiro"]
    end

    it 'Bitcoin verdadeiro' do 
      payment_method = PaymentMethod.new(bitcoin: true)
      result = payment_method.available_methods_to_select_translated
      expect(result).to eq ["Bitcoin"]
    end

    it 'Transferência Bancária verdadeiro' do 
      payment_method = PaymentMethod.new(bank_transfer: true)
      result = payment_method.available_methods_to_select_translated
      expect(result).to eq ["Transferência Bancária"]
    end

    it 'Todos os metodos verdadeiro' do 
      payment_method = PaymentMethod.new(pix: true, boleto: true, credit_card: true, debit_card: true, money: true,
                                        bitcoin: true, bank_transfer: true)
      result = payment_method.available_methods_to_select_translated
      expect(result).to eq ["PIX", "Boleto", "Cartão de Crédito", "Cartão de Débito", "Dinheiro",
                            "Bitcoin", "Transferência Bancária"]
    end

  end

  describe "#value" do 
    it 'pix verdadeiro' do 
      payment_method = PaymentMethod.new(pix: true)
      pix = payment_method.value("pix")
      boleto = payment_method.value("boleto")
      credit_card = payment_method.value("credit_card")
      debit_card = payment_method.value("debit_card")
      money = payment_method.value("money")
      bitcoin =payment_method.value("bitcoin")
      bank_transfer =payment_method.value("bank_transfer")

      expect(pix).to eq true
      expect(boleto).to eq nil
      expect(credit_card).to eq nil
      expect(debit_card).to eq nil
      expect(money).to eq nil
      expect(bitcoin).to eq nil
      expect(bank_transfer).to eq nil
    end

    it 'boleto verdadeiro' do 
      payment_method = PaymentMethod.new(boleto: true)
      pix = payment_method.value("pix")
      boleto = payment_method.value("boleto")
      credit_card = payment_method.value("credit_card")
      debit_card = payment_method.value("debit_card")
      money = payment_method.value("money")
      bitcoin =payment_method.value("bitcoin")
      bank_transfer =payment_method.value("bank_transfer")

      expect(pix).to eq nil
      expect(boleto).to eq true
      expect(credit_card).to eq nil
      expect(debit_card).to eq nil
      expect(money).to eq nil
      expect(bitcoin).to eq nil
      expect(bank_transfer).to eq nil
    end

    it 'Cartão de crédito verdadeiro' do 
      payment_method = PaymentMethod.new(credit_card: true)
      pix = payment_method.value("pix")
      boleto = payment_method.value("boleto")
      credit_card = payment_method.value("credit_card")
      debit_card = payment_method.value("debit_card")
      money = payment_method.value("money")
      bitcoin =payment_method.value("bitcoin")
      bank_transfer =payment_method.value("bank_transfer")

      expect(pix).to eq nil
      expect(boleto).to eq nil
      expect(credit_card).to eq true
      expect(debit_card).to eq nil
      expect(money).to eq nil
      expect(bitcoin).to eq nil
      expect(bank_transfer).to eq nil
    end

    it 'cartão de debito verdadeiro' do 
      payment_method = PaymentMethod.new(debit_card: true)
      pix = payment_method.value("pix")
      boleto = payment_method.value("boleto")
      credit_card = payment_method.value("credit_card")
      debit_card = payment_method.value("debit_card")
      money = payment_method.value("money")
      bitcoin =payment_method.value("bitcoin")
      bank_transfer =payment_method.value("bank_transfer")

      expect(pix).to eq nil
      expect(boleto).to eq nil
      expect(credit_card).to eq nil
      expect(debit_card).to eq true
      expect(money).to eq nil
      expect(bitcoin).to eq nil
      expect(bank_transfer).to eq nil
    end

    it 'Dinheiro verdadeiro' do 
      payment_method = PaymentMethod.new(money: true)
      pix = payment_method.value("pix")
      boleto = payment_method.value("boleto")
      credit_card = payment_method.value("credit_card")
      debit_card = payment_method.value("debit_card")
      money = payment_method.value("money")
      bitcoin =payment_method.value("bitcoin")
      bank_transfer =payment_method.value("bank_transfer")

      expect(pix).to eq nil
      expect(boleto).to eq nil
      expect(credit_card).to eq nil
      expect(debit_card).to eq nil
      expect(money).to eq true
      expect(bitcoin).to eq nil
      expect(bank_transfer).to eq nil
    end

    it 'Bitcoin verdadeiro' do 
      payment_method = PaymentMethod.new(bitcoin: true)
      pix = payment_method.value("pix")
      boleto = payment_method.value("boleto")
      credit_card = payment_method.value("credit_card")
      debit_card = payment_method.value("debit_card")
      money = payment_method.value("money")
      bitcoin =payment_method.value("bitcoin")
      bank_transfer =payment_method.value("bank_transfer")

      expect(pix).to eq nil
      expect(boleto).to eq nil
      expect(credit_card).to eq nil
      expect(debit_card).to eq nil
      expect(money).to eq nil
      expect(bitcoin).to eq true
      expect(bank_transfer).to eq nil
    end

    it 'Transferência Bancária verdadeiro' do 
      payment_method = PaymentMethod.new(bank_transfer: true)
      pix = payment_method.value("pix")
      boleto = payment_method.value("boleto")
      credit_card = payment_method.value("credit_card")
      debit_card = payment_method.value("debit_card")
      money = payment_method.value("money")
      bitcoin =payment_method.value("bitcoin")
      bank_transfer =payment_method.value("bank_transfer")

      expect(pix).to eq nil
      expect(boleto).to eq nil
      expect(credit_card).to eq nil
      expect(debit_card).to eq nil
      expect(money).to eq nil
      expect(bitcoin).to eq nil
      expect(bank_transfer).to eq true
    end

    it 'Todos os metodos verdadeiro' do 
      payment_method = PaymentMethod.new(pix: true, boleto: true, credit_card: true, debit_card: true, money: true,
                                        bitcoin: true, bank_transfer: true)
      pix = payment_method.value("pix")
      boleto = payment_method.value("boleto")
      credit_card = payment_method.value("credit_card")
      debit_card = payment_method.value("debit_card")
      money = payment_method.value("money")
      bitcoin =payment_method.value("bitcoin")
      bank_transfer =payment_method.value("bank_transfer")

      expect(pix).to eq true
      expect(boleto).to eq true
      expect(credit_card).to eq true
      expect(debit_card).to eq true
      expect(money).to eq true
      expect(bitcoin).to eq true
      expect(bank_transfer).to eq true
    end

    it 'Todos os metodos falso' do 
      payment_method = PaymentMethod.new()
      pix = payment_method.value("pix")
      boleto = payment_method.value("boleto")
      credit_card = payment_method.value("credit_card")
      debit_card = payment_method.value("debit_card")
      money = payment_method.value("money")
      bitcoin =payment_method.value("bitcoin")
      bank_transfer =payment_method.value("bank_transfer")

      expect(pix).to eq nil
      expect(boleto).to eq nil
      expect(credit_card).to eq nil
      expect(debit_card).to eq nil
      expect(money).to eq nil
      expect(bitcoin).to eq nil
      expect(bank_transfer).to eq nil
    end
  end


end
