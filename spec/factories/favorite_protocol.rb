# frozen_string_literal: true

FactoryBot.define do
  factory :favorite_protocol do
    association :user
    association :protocol
  end
end
