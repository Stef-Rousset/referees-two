class LexiconResult < ApplicationRecord
  belongs_to :user

  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }

  def self.score(email, month)
    joins(:user).where(users: { email: email }).where('extract(month from lexicon_results.created_at) = ?', month)&.first&.score
  end
end
