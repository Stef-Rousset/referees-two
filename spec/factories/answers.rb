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
FactoryBot.define do

  factory :answer do

    trait :valid do
      explanation { 'réponse exacte' }
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

