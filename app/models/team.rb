class Team < ApplicationRecord
  has_secure_token

  validates :name, presence: true

  has_many :members
  has_many :pair_histories, through: :members

  def to_param
    token
  end
end
