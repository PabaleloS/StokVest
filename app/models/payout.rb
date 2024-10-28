class Payout < ApplicationRecord
  belongs_to :user
  belongs_to :member
  belongs_to :stokvel
  # validates :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def formatted_date
    created_at.strftime("%B %d, %Y")
  end
end
