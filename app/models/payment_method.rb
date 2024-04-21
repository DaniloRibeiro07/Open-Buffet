class MandatoryPaymentMethod < ActiveModel::Validator
  def validate(record)
    unless record.pix || record.boleto || record.credit_card || record.debit_card || record.money || record.bitcoin || record.bank_transfer
      record.errors.add :PaymentMethod, 'Um método de pagamento deve ser escolhido'
    end
  end
end

class PaymentMethod < ApplicationRecord
  validates_with MandatoryPaymentMethod

  def all_available_methods_to_select
    PaymentMethod.attribute_names.reject { |method| ['id', 'created_at', 'updated_at'].include? method }            
  end

  def all_available_methods_and_values_to_select
    all_available_methods_to_select.map{|method| {name: method, value: value(method)}}
  end

  def available_methods_to_select_translated
    PaymentMethod.attribute_names.select { |method| value(method).class == true.class }
                                  .map{|method| PaymentMethod.human_attribute_name(method)} 
  end

  def value(attribute)
    values_at(attribute)[0]
  end
end

