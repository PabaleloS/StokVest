class Payout < ApplicationRecord
  belongs_to :user
  belongs_to :member
  belongs_to :stokvel
  validates :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
