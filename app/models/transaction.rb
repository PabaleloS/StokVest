class Transaction < ApplicationRecord
  belongs_to :member
  enum transaction_type: { contribution: 0, payout: 1 }

  belongs_to :member
end
