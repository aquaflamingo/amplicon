# frozen_string_literal: true

FactoryBot.define do
  factory :protocol, aliases: [:proto] do
    sequence(:name) { |n| "name_#{n}" }
    description { 'description' }

    private { false }

    association :user, factory: :user
  end
end
