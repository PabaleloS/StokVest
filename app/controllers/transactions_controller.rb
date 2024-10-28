class TransactionsController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in

  def index
    @contributions = current_user.contributions.includes(:stokvel)
    @payouts = current_user.payouts.includes(:stokvel)
  end

  def show_contribution
    @contribution = current_user.contributions.find(params[:id])
    # Additional logic to display details can be added here
  end

  def show_payout
    @payout = current_user.payouts.find(params[:id])
    # Additional logic to display details can be added here
  end


end
