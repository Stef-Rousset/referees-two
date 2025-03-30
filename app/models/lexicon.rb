class Lexicon < ApplicationRecord
  has_one :lexicon_answer, dependent: :destroy

  accepts_nested_attributes_for :lexicon_answer, allow_destroy: true

  validates :statement, :prop_one, :prop_two, :prop_three, :category, presence: true
  validates :statement, length: { minimum: 2 }
  validates :prop_one, length: { minimum: 2 }
  validates :prop_two, length: { minimum: 2 }
  validates :prop_three, length: { minimum: 2 }

  enum category: { rules: 1, actions: 2, prep_hab: 3, other: 4 }


  def self.filter_by_category(category)
    where(category: category)
  end
end
