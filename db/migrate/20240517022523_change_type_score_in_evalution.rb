class ChangeTypeScoreInEvalution < ActiveRecord::Migration[7.1]
  def change
    change_column :evaluations, :score, :integer
  end
end
