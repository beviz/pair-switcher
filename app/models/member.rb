class Member < ApplicationRecord
  has_many :pair_histories, -> { recent_paired }, foreign_key: :member_id
  has_many :pairs, through: :pair_histories, source: :target

  has_one :latest_pair_history, -> { recent_paired }, class_name: PairHistory.to_s, foreign_key: :member_id
  has_one :latest_pair, through: :latest_pair_history, source: :target

  validates :name, presence: true, uniqueness: true

  scope :recent, -> { order(created_at: :desc) }
  scope :with_latest_pair, -> { includes(latest_pair_history: :target) }
end
