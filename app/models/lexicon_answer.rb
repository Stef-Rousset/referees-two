# == Schema Information
#
# Table name: lexicon_answers
#
#  id         :bigint           not null, primary key
#  good_prop  :integer          not null
#  lexicon_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LexiconAnswer < ApplicationRecord
  belongs_to :lexicon

  validates :good_prop, presence: true

  enum good_prop: { un: 1, deux: 2, trois: 3 }
end
