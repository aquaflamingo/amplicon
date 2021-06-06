FactoryBot.define do 
  factory :repository, aliases: [:repo] do 
    sequence(:name) {|n| "name_#{n}"}
    description { "description" }
    resource { :protocol }
  end
end
