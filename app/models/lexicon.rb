# == Schema Information
#
# Table name: lexicons
#
#  id         :bigint           not null, primary key
#  statement  :text             not null
#  prop_one   :text             not null
#  prop_two   :text             not null
#  prop_three :text             not null
#  category   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Lexicon < ApplicationRecord
  has_one :lexicon_answer, dependent: :destroy

  accepts_nested_attributes_for :lexicon_answer, allow_destroy: true

  validates :statement, :prop_one, :prop_two, :prop_three, :category, presence: true
  validates :statement, length: { minimum: 2 }
  validates :prop_one, length: { minimum: 2 }
  validates :prop_two, length: { minimum: 2 }
  validates :prop_three, length: { minimum: 2 }

  enum category: { basics: 1, actions: 2, prep: 3, other: 4 }


  def self.filter_by_category(category)
    where(category: category)
  end
end
