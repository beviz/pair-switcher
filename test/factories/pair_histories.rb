FactoryBot.define do
  factory :pair_history do
    paired_at { Time.current }
  end
end
