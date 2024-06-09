class DropMissedQuestion < ActiveRecord::Migration[7.0]
  def change
    drop_table :missed_questions
  end
end
