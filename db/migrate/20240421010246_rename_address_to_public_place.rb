class RenameAddressToPublicPlace < ActiveRecord::Migration[7.1]
  def change
    rename_column :buffet_registrations, :address, :public_place
  end
end
