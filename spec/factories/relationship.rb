# frozen_string_literal: true

FactoryBot.define do
  factory :relationship, aliases: [:follow] do
    association :follower, factory: :user
    association :followed, factory: :user
  end
end
