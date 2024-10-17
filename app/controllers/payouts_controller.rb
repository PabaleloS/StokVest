class PayoutsController < ApplicationController

  def index
    @stokvel = Stokvel.find(params[:stokvel_id]) # Assuming you have the stokvel id available in params

    @payouts = @stokvel.payouts.order(created_at: :desc)
    @members = @stokvel.members.all

    respond_to do |format|
      format.html
      format.json { render json: @payouts }
    end
  end

  def show
    @payouts = @stokvel.payouts.order(created_at: :desc)
    @member = @stokvel.members.find_by(user_id: current_user.id)
    @last_payout = @payouts.last
    @last_withdrawals = @stokvel.withdrawals.order(created_at: :desc).limit(3)
  end

  def new
    @stokvel = Stokvel.find(params[:stokvel_id])
    @payout = Payout.new
    @stokvel.balance ||= 0
  end

  def create
    @member = @stokvel.members.find(params[:member_id])
    @payout = @stokvel.payouts.new(payout_params)
    @payout.member = @member

    respond_to do |format|
      if @payout.save
        format.html { redirect_to stokvel_payouts_path(@stokvel), notice: "Payout was successfully created." }
        format.json { render :show, status: :created, location: @payout }
      else
        format.html { render :new }
        format.json { render json: @payout.errors, status: :unprocessable_entity }
      end
    end
    end

  private

  def payout_params
    params.require(:payout).permit(:amount, :member_id, :stokvel_id)
  end
end
