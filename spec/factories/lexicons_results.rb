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
FactoryBot.define do
  factory :lexicons_result do

    trait :valid do
      score { 18 }
      user { nil }
    end

    trait :created_one_month_ago do
      score { 14 }
      user { nil }
      created_at { DateTime.now - 1.month }
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
