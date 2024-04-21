class ChangeColumnCnpjIntegerToString < ActiveRecord::Migration[7.1]
  def change
    change_column :buffet_registrations, :cnpj, :string
  end
end
