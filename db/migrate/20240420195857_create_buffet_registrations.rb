class CreateBuffetRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :buffet_registrations do |t|
      t.string :trading_name
      t.string :company_name
      t.integer :cnpj
      t.integer :phone
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :state
      t.string :city
      t.string :zip
      t.text :description
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
