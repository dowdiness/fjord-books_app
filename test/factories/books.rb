# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Lorem.word }
    memo { Faker::Lorem.sentences(number: 3) }
    author { Faker::Name.name }
    picture { File.open(Rails.root.join('db/seeds/no-image.png')) }
  end
end
