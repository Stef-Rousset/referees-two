FactoryBot.define do
  factory :lexicon do

    trait :valid do
      statement { "première question" }
      prop_one { "une" }
      prop_two { "deux" }
      prop_three { "trois" }
      category { 2 } # actions
    end

    trait :invalid_statement do
      statement { "p" }
      prop_one { "une" }
      prop_two { "deux" }
      prop_three { "trois" }
      category { 1 }
    end

    trait :missing_category do
      statement { "première question" }
      prop_one { "une" }
      prop_two { "deux" }
      prop_three { "trois" }
      category {}
    end

    trait :basics do
      statement { "première règle" }
      prop_one { "règle une" }
      prop_two { "règle deux" }
      prop_three { "règle trois" }
      category { 1 }
    end

    trait :prep do
      statement { "première prep" }
      prop_one { "prep une" }
      prop_two { "prep deux" }
      prop_three { "prep trois" }
      category { 3 }
    end

    trait :other do
      statement { "première autre" }
      prop_one { "autre une" }
      prop_two { "autre deux" }
      prop_three { "autre trois" }
      category { 4 }
    end
  end
end
