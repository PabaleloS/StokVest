class Message < ApplicationRecord
  belongs_to :stokvel
  belongs_to :member

  validates :content, presence: true


  def sender?(current_user)
    self.member.user == current_user
  end

end
