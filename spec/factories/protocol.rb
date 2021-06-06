FactoryBot.define do 
  factory :protocol, aliases: [:proto] do 
    sequence(:name) {|n| "name_#{n}"}
    description { "description" }
  end
end
