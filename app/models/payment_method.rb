class PaymentMethod < ApplicationRecord
  validate :some_method_must_be_selected

  def some_method_must_be_selected
    unless self.pix || self.boleto || self.credit_card || self.debit_card || self.money || self.bitcoin || self.bank_transfer
      self.errors.add :any, 'método de pagamento deve ser escolhido'
    end
  end
end

