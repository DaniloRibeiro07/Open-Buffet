class CreateEventTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :event_types do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :minimum_quantity
      t.integer :maximum_quantity
      t.integer :duration
      t.text :menu
      t.boolean :alcoholic_beverages
      t.boolean :decoration
      t.boolean :valet
      t.boolean :insider
      t.boolean :outsider

      t.timestamps
    end
  end
end
