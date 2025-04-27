FactoryBot.define do
  sequence :email do |n|
    "user#{n}@gmail.com"
  end

  factory :user do
    email { generate(:email) }

    trait :admin do
      password { 'password' }
      role { 2 }
    end

    trait :normal do
      password { 'motdepasse' }
      role { 0 }
    end

    trait :contributor do
      password { 'motdepasse' }
      role { 1 }
    end

    trait :intern do
      password { 'mdp123'}
      role { 3 }
    end
  end
end
