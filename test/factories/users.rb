# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { 'password' }
    name { Faker::Name.name }
    sequence(:postal_code) { |n| "123-#{n.to_s.rjust(4, '0')}" }
    address { Faker::Address.full_address }
    self_introduction { "こんにちは、#{name}です。" }
  end
end
