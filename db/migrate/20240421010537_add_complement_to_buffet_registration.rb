class AddComplementToBuffetRegistration < ActiveRecord::Migration[7.1]
  def change
    add_column :buffet_registrations, :complement, :text
  end
end
