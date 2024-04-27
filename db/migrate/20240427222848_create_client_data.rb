class CreateClientData < ActiveRecord::Migration[7.1]
  def change
    create_table :client_data do |t|
      t.integer :cpf
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
