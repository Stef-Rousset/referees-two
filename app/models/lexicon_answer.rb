class LexiconAnswer < ApplicationRecord
  belongs_to :lexicon

  validates :good_prop, presence: true

  enum good_prop: { un: 1, deux: 2, trois: 3 }
end
