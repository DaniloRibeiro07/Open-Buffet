class ChangeDataTypeForCpfToClientData < ActiveRecord::Migration[7.1]
  def change
    change_column :client_data, :cpf, :string
  end
end
