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
