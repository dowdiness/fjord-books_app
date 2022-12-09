# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentences(number: 10) }
    association :user
  end
end
