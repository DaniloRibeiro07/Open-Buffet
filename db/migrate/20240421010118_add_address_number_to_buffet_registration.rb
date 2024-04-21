class AddAddressNumberToBuffetRegistration < ActiveRecord::Migration[7.1]
  def change
    add_column :buffet_registrations, :address_number, :string
  end
end
