# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer          default("normal")
#
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
