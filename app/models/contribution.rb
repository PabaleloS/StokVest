class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :member
  belongs_to :stokvel

  validates :date, presence: true
  validates :contribution_amount, presence: true, numericality: { greater_than: 0 }

  enum status: { pending: 0, completed: 1, failed: 2 }

  def transaction_number
    "TRX-#{id.to_s.rjust(6, '0')}"
  end
end
