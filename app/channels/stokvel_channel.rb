class StokvelChannel < ApplicationCable::Channel
  def subscribed
      stokvel = Stokvel.find(params[:id])
      stream_for stokvel
  end

  def unsubscribed

  end
end
