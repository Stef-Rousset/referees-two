FactoryBot.define do

  factory :answer do

    trait :valid do
      explanation { 'bonne réponse' }
      good_prop { 'un' }
      question_id { }
    end

    trait :empty_explanation do
      explanation { '' }
      good_prop { 'un' }
      question_id { }
    end

    trait :too_short_explanation do
      explanation { 'b' }
      good_prop { 'un' }
      question_id { }
    end
  end
end

