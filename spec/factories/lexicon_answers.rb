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
FactoryBot.define do
  factory :lexicon_answer do

    trait :valid do
      good_prop { "un" }
      lexicon_id { }
    end

    trait :invalid do
      good_prop { "" }
      lexicon_id { }
    end
  end
end
