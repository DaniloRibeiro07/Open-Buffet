class AddExtraServiceToOrder < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :extra_service, foreign_key: true
  end
end
