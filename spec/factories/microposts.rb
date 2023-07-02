# frozen_string_literal: true

FactoryBot.define do
  factory :micropost do
    content { 'MyText' }
    user { nil }
  end
end
