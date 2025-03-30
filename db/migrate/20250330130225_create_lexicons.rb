class CreateLexicons < ActiveRecord::Migration[7.0]
  def change
    create_table :lexicons do |t|
      t.text :statement, null: false
      t.text :prop_one, null: false
      t.text :prop_two, null: false
      t.text :prop_three, null: false
      t.integer :category, null: false

      t.timestamps
    end
  end
end
