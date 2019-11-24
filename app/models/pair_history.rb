class PairHistory < ApplicationRecord
  belongs_to :member
  belongs_to :target, class_name: Member.to_s

  validates :member, :target, :paired_at, presence: true

  scope :recent_paired, -> { order(paired_at: :desc) }

  def self.last_pair_of(member)
    where(member: member).recent_paired.first&.target
  end

  def self.pair!(member, target, time)
    create! member: member, target: target, paired_at: time
    create! member: target, target: member, paired_at: time
  end

  def self.last_paired_at
    maximum(:paired_at)
  end

  def self.rollback!
    return false unless last_paired_at = recent_paired.first&.paired_at

    where(paired_at: last_paired_at).destroy_all
    true
  end
end
