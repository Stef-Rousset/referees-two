class CreateLexiconAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :lexicon_answers do |t|
      t.integer :good_prop, null: false
      t.references :lexicon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
