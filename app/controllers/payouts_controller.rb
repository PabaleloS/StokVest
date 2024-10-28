class PayoutsController < ApplicationController
  def index
    @stokvel = Stokvel.find(params[:stokvel_id])
    @payouts = @stokvel.payouts.order(created_at: :desc)
    @members = @stokvel.members.all
    @payout = Payout.new

    @last_payout = {}
    @members.each do |member|
      last_payout = member.payouts.last
      if last_payout
        @last_payout[member.id] = { date: last_payout.created_at, amount: last_payout.amount }
      end
    end

    # Update the user balance
  @user = current_user
  @user.balance -= @payout.amount if @payout.save
  @user.save


    respond_to do |format|
      format.html
      format.json { render json: @payouts }
    end
  end

  def new
    @stokvel = Stokvel.find(params[:stokvel_id])
    @payout = Payout.new
    @stokvel.balance ||= 0
  end

  def create
    Rails.logger.debug "Params: #{params.inspect}"
    @stokvel = Stokvel.find(params[:stokvel_id])

    # Create a new payout associated with the stokvel
    @payout = @stokvel.payouts.new(payout_params)

    if params[:payout].nil?
      redirect_to stokvel_payouts_path(@stokvel), alert: "Payout parameters are missing."
      return
    end

    puts "Member ID: #{params[:payout][:member_id]}" if params[:payout][:member_id].present?

    begin
      @member = @stokvel.members.find(params[:payout][:member_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to stokvel_payouts_path(@stokvel), alert: "Invalid member selected."
      return
    end

    @payout.member = @member
    @payout.user = current_user # Assuming you have a method to get the current user

    # Check if the payout amount exceeds the stokvel's balance
    if @payout.amount > @stokvel.balance
      respond_to do |format|
        format.html { redirect_to stokvel_payouts_path(@stokvel), alert: "Payout amount exceeds the available balance." }
        format.json { render json: { error: "Payout amount exceeds the available balance." }, status: :unprocessable_entity }
      end
      return
    end

    respond_to do |format|
      if @payout.save
        # Update the stokvel balance
        @stokvel.update(balance: @stokvel.balance - @payout.amount)

        # Update the member's user balance
        member_user = @member.user # Assuming each member has a user associated with them
        member_user.update(balance: member_user.balance + @payout.amount)

        # Update the last payout for the specific member
        @member.update(last_payout_date: @payout.created_at, last_payout_amount: @payout.amount)

        # Update the next withdrawal list (implement your logic here)
        update_next_withdrawal_list(@member)

        # Move the member to the bottom of the list
      # move_member_to_bottom(@member)


        Rails.logger.debug "Payout saved successfully. Redirecting to stokvel show page."
        format.html { redirect_to stokvel_path(@stokvel), notice: "Payout was successfully created on #{@payout.created_at}." }
        format.json { render :show, status: :created, location: @payout }
      else
        Rails.logger.debug "Payout save failed with errors: #{@payout.errors.full_messages.join(", ")}"
        format.html { render :index } # Render index to show errors
        format.json { render json: @payout.errors, status: :unprocessable_entity }
      end
    end
  end

    private

    def payout_params
      params.require(:payout).permit(:member_id, :amount, :date)
    end
  end

  private

  def update_next_withdrawal_list(member)
    member.update(next_withdrawal_date: Date.today + 30)
  end

  # def move_member_to_bottom(member)
  #   # Update the next withdrawal date to move the member to the bottom
  #   member.update(next_withdrawal_date: Date.today + 30) # Adjust the date as needed
  # end

  def payout_params
    params.require(:payout).permit(:member_id, :amount, :date)
  end


  def update_user_balance
    user&.update!(balance: user.balance - amount)
  end

  def reorder_members(stokvel)
    # Reorder members based on next_withdrawal_date
    stokvel.members.order(next_withdrawal_date: :asc).each do |member|
      # Logic to move the member to the bottom of the list if they just received a payout
      if member.next_withdrawal_date == Date.today + 30
        # Move this member to the bottom of the list
        member.update(next_withdrawal_date: Date.today + 30 + 1.day) # Adjust the date to ensure they are at the bottom
      end
    end
  end
