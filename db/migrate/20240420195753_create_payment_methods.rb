class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.boolean :pix
      t.boolean :boleto
      t.boolean :credit_card
      t.boolean :debit_card
      t.boolean :money
      t.boolean :bitcoin
      t.boolean :bank_transfer

      t.timestamps
    end
  end
end
