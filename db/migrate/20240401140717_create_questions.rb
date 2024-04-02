class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :statement, null: false
      t.text :prop_one, null: false
      t.text :prop_two, null: false
      t.text :prop_three, null: false
      t.integer :level, null: false
      t.integer :category, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
