class Member < ApplicationRecord
  has_many :pair_histories, -> { recent_paired }, foreign_key: :member_id, dependent: :destroy
  has_many :pair_histories_as_target, -> { recent_paired }, class_name: PairHistory.to_s, foreign_key: :target_id, dependent: :destroy
  has_many :pairs, through: :pair_histories, source: :target

  has_one :latest_pair_history, -> { recent_paired }, class_name: PairHistory.to_s, foreign_key: :member_id
  has_one :latest_pair, through: :latest_pair_history, source: :target
  belongs_to :team

  validates :name, presence: true, uniqueness: true

  scope :available, -> { where(disabled_at: nil) }
  scope :available_first, -> { order('disabled_at DESC NULLS FIRST') }
  scope :recent, -> { order(created_at: :desc) }
  scope :with_latest_pair, -> { includes(latest_pair_history: :target) }

  def disable
    self.update disabled_at: Time.current
  end

  def enable
    self.update disabled_at: nil
  end

  def disabled?
    !disabled_at.nil?
  end
end
