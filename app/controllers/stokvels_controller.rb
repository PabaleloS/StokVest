class StokvelsController  < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @stokvels = @user.stokvels
    @stokvel = @stokvels.first
    if params[:id].present?
      @member = Member.find_by(id: params[:id], user_id: current_user.id)
      if @member.nil?
        # Handle the case where the member with the given ID does not belong to the current user
        flash[:alert] = "Member not found."
        redirect_to some_path # Redirect to an appropriate page or handle the error as needed
        return
      end
      @members = [@member] # Assign the found member to the @members instance variable
    else
      @member = nil
      @members = @user.members
    end

    @pending_stokvels = Stokvel.joins(:members).where(members: { user_id: current_user, status: 'pending' })
    @pending_stokvels ||= []
    @accepted_stokvel = Stokvel.joins(:members).where(members: { user_id: current_user, status: 'accepted' })
    @accepted_stokvels ||= []
    @declined_stokvel = Stokvel.joins(:members).where(members: { user_id: current_user, status: 'declined' })
    @declined_stokvels ||= []
  end

  def show
    @stokvel = Stokvel.find(params[:id])
    @user = current_user
    # @message = Message.new
    @all_members = @stokvel.members
    @accepted_members = @stokvel.members.where(status: "accepted")
    @pending_members = @stokvel.members.where(status: "pending")
  end

  def new
    @stokvel = Stokvel.new
    @user = current_user
  end

  def create
    @stokvel = Stokvel.new(stokvel_params)
    @stokvel.user = current_user
    if @stokvel.save
      Member.create(stokvel: @stokvel, user: current_user, join_date: Date.today, status: "accepted")
      redirect_to new_stokvel_member_path(@stokvel), notice: 'Stokvel was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def disburse
  #   stokvel = Stokvel.find(params[:id])
  #   member = stokvel.next_member
  #   # Update balances
  #   ActiveRecord::Base.transaction do
  #     member.update!(balance: member.balance + stokvel.balance)
  #     puts "Member balance after update: #{member.balance}" # Debug output
  #     member.user.update(balance: member.user.balance + stokvel.balance)
  #     puts "User balance after update: #{member.user.balance}" # Debug output
  #     # Reset Stokvel balance
  #     stokvel.update(balance: 0)
  #     # Redirect with notice
  #     redirect_to stokvel_path(stokvel), notice: "#{stokvel.contribution_amount} disbursed to #{member.user.first_name}. #{member.user.first_name}'s new balance is #{member.user.balance}."
  #   rescue ActiveRecord::RecordInvalid => e
  #     # Handle transaction failure
  #     flash.now[:alert] = "Payout unsuccessful, please try again. Error: #{e.message}"
  #     render :show
  #   end
  # end

  def next_contribution_date
    if contribution_frequency == 'monthly'
      created_at + 1.month
    else
      # Handle other frequencies if needed
    end
  end

  def accept_invite
    @user = current_user
    @stokvel = Stokvel.find(params[:id])
    @member = @stokvel.members.find_by(user_id: @user.id)
    if @member.update(status: :accepted)
      redirect_to stokvel_path(@stokvel), notice: "You have accepted the invite to join this stokvel group."
    else
      redirect_to stokvels_path, alert: "An error occurred, please try again"
    end
  end

  private

  def stokvel_params
    params.require(:stokvel).permit(:name, :description, :contribution_amount, :contribution_frequency)
  end
end
