class Stokvel < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :contributions, dependent: :destroy
  has_many :payouts, dependent: :destroy
  has_many :messages
  # has_many :transactions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :contribution_amount, presence: true, numericality: { greater_than: 0 }
  validates :contribution_frequency, presence: true

  enum contribution_frequency: { daily: 0, weekly: 1, monthly: 2 }

  def next_contribution_date
    if contribution_frequency == 'monthly'
      created_at + 1.month
    else
      # Handle other frequencies if needed
    end
  end
  # def total_balance
  #   transactions.sum(:amount)
  # end

  # def total_contributions
  #   transactions.where(transaction_type: :contribution).sum(:amount)
  # end

  # def total_payouts
  #   transactions.where(transaction_type: :payout).sum(:amount)
  # end

  # def current_cycle_contributions
  #   # Implement logic to calculate contributions for the current cycle
  #   # This will depend on how you define cycles in your app
  # end

  def next_payout_date
    # Implement logic to determine the next payout date
    # This will depend on your payout schedule logic
  end
end
