FactoryBot.define do 
  factory :user, aliases: [:u] do 
    sequence(:username) { |n| "user_#{n}"}
    sequence(:email) { |n| "user_#{n}@amplicon.app" }
    password { "password" }
  end
end
