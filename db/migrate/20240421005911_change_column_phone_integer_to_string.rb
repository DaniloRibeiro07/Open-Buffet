class ChangeColumnPhoneIntegerToString < ActiveRecord::Migration[7.1]
  def change
    change_column :buffet_registrations, :phone, :string
  end
end
