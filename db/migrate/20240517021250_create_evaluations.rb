class CreateEvaluations < ActiveRecord::Migration[7.1]
  def change
    create_table :evaluations do |t|
      t.references :order, null: false, foreign_key: true
      t.float :score
      t.text :comment

      t.timestamps
    end
  end
end
