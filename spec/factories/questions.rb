# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  statement  :text             not null
#  prop_one   :text             not null
#  prop_two   :text             not null
#  prop_three :text             not null
#  level      :integer          not null
#  category   :integer          not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do

  factory :question do

    trait :valid do
      statement { 'super question' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'départemental' }
      category { 'généralités' }
      user_id { }
    end

    trait :empty_statement do
      statement {  }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'départemental' }
      category { 'généralités' }
      user_id { }
    end

    trait :too_short_statement do
      statement { 'a' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'départemental' }
      category { 'généralités' }
      user_id { }
    end

    trait :dep_g do
      statement { 'une autre question' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'départemental' }
      category { 'généralités' }
      user_id { }
    end

    trait :dep_f do
      statement { 'super question' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'départemental' }
      category { 'fleuret' }
      user_id { }
    end

    trait :dep_e do
      statement { 'super question' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'départemental' }
      category { 'épée' }
      user_id { }
    end

    trait :dep_s do
      statement { 'super question' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'départemental' }
      category { 'sabre' }
      user_id { }
    end

    trait :reg_g do
      statement { 'super question' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'régional' }
      category { 'généralités' }
      user_id { }
    end

    trait :reg_f do
      statement { 'super question' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'régional' }
      category { 'fleuret' }
      user_id { }
    end

    trait :reg_e do
      statement { 'super question' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'régional' }
      category { 'épée' }
      user_id { }
    end

    trait :reg_s do
      statement { 'super question' }
      prop_one { 'vrai' }
      prop_two { 'faux' }
      prop_three { 'peut être' }
      level { 'régional' }
      category { 'sabre' }
      user_id { }
    end
  end
end

