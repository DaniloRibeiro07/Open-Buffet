class CreateExtraServices < ActiveRecord::Migration[7.1]
  def change
    create_table :extra_services do |t|
      t.boolean :alcoholic_beverages
      t.boolean :decoration
      t.boolean :valet

      t.timestamps
    end
  end
end
