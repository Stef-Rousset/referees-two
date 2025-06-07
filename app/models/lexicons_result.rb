# == Schema Information
#
# Table name: lexicons_results
#
#  id         :bigint           not null, primary key
#  score      :integer          not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LexiconsResult < ApplicationRecord
  belongs_to :user

  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }

  def self.results(email)
    joins(:user).where(users: { email: email })
  end

  # méthode appelée sur une active record relation de LexiconResults d'un user
  def self.month_score(month)
    where('extract(month from lexicons_results.created_at) = ?', month)&.first&.score
  end
end
