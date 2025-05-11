FactoryBot.define do
  factory :lexicon_result do

    trait :valid do
      score { 18 }
      user { nil }
    end

    trait :empty_score do
      score { }
      user { nil }
    end

    trait :not_number_score do
      score { "douze" }
      user { nil }
    end

    trait :score_less_than_zero do
      score { -5 }
      user { nil }
    end

    trait :score_greather_than_twenty do
      score { 23 }
      user { nil }
    end
  end
end
