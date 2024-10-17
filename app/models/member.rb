class Member < ApplicationRecord
  belongs_to :stokvel
  belongs_to :user
  has_many :contributions, through: :stokvel
  has_many :payouts, through: :stokvel
  has_many :transactions, dependent: :destroy
  # has_many :messages, dependent: :destroy

  enum status: { pending: 0, accepted: 1, declined: 2 }
end
