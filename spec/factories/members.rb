FactoryBot.define do
  factory :member do
    sequence(:name) { |n| "member_#{n}" }
  end
end
