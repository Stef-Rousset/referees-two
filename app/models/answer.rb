# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  explanation :text             not null
#  good_prop   :integer          not null
#  question_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Answer < ApplicationRecord
  belongs_to :question

  validates :explanation, :good_prop, presence: true
  validates :explanation, length: { minimum: 2 }

  enum good_prop: { un: 1, deux: 2, trois: 3 }
end
