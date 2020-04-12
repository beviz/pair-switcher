FactoryBot.define do
  factory :member do
    sequence(:name) { |n| "member_#{n}" }

    trait :disabled do |member|
      disabled_at { Time.current }
    end
  end
end
