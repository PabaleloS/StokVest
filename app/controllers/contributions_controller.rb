class ContributionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @stokvel = Stokvel.find(params[:stokvel_id])
    @members = @stokvel.members.includes(:contributions)
    @last_contribution = {}
    @last_deposits = {}

    @members.each do |member|
      last_contribution = member.contributions.order(created_at: :desc).first
      if last_contribution
        @last_contribution[member.id] = { date: last_contribution.created_at.strftime('%d/%m/%Y'), amount: last_contribution.contribution_amount }
        @last_deposits[member.id] = { contribution_amount: last_contribution.contribution_amount }
      else
        @last_contribution[member.id] = { date: 'No Contributions yet.', amount: nil }
        @last_deposits[member.id] = { contribution_amount: nil }
      end
    end
  end

  def show
    @contribution = Contribution.find(params[:id])
    @member = @contribution.member
    @stokvel = @contribution.stokvel
  end

  def new
    puts "Params: #{params.inspect}"
    @stokvel = Stokvel.find(params[:stokvel_id])
    puts "@stokvel: #{@stokvel.inspect}"
    @contribution_amount = @stokvel.contribution_amount
    @contribution = Contribution.new
    @stokvel.balance ||= 0
  end

  def success; end

  # def create
  #   @current_user = current_user
  #   @stokvel = Stokvel.find(params[:stokvel_id])
  #   @contribution = @stokvel.contributions.new(contribution_params)
  #   @contribution.user = current_user

  #   member = @stokvel.members.find_by(user_id: current_user.id)
  #   if member.nil?
  #     redirect_to root_path, alert: "You are not a member of this Stokvel."
  #     return
  #   end
  #   @contribution.member = member
  #   @contribution.date = Date.today
  #   @contribution.amount = contribution_params[:contribution_amount].to_d
  #   @stokvel.balance ||= 0
  #   @stokvel.balance += @contribution.amount
  #   if @contribution.save && @stokvel.save
  #     redirect_to stokvel_contribution_path(@stokvel, @contribution), notice: "Contribution was successfully ."
  #   else
  #     puts @contribution.errors.full_messages
  #     render :new
  #   end
  # end

  def create
    @current_user = current_user
    @stokvel = Stokvel.find(params[:stokvel_id])
    @contribution = @stokvel.contributions.new(contribution_params)
    @contribution.user = @current_user

    puts "Contribution attributes: #{@contribution.attributes.inspect}"
    puts "Params: #{params.inspect}"

    member = @stokvel.members.find_by(user_id: @current_user.id)
    if member.nil?
      redirect_to root_path, alert: "You are not a member of this Stokvel."
      return
    end
    @contribution.member = member
    @contribution.date = Date.today
    @contribution.amount = contribution_params[:contribution_amount].to_d
    @stokvel.balance ||= 0

    # Handle payment method
    payment_method = params[:contribution][:payment_method]

    puts "Payment method: #{payment_method}"

    if payment_method == 'user_balance'
      if @current_user.balance <= 0
        redirect_to new_stokvel_contribution_path(@stokvel), alert: "Your balance is zero. Please add funds to your account."
        return
      elsif @current_user.balance < @contribution.amount
        redirect_to new_stokvel_contribution_path(@stokvel), alert: "Insufficient balance. Please add funds to your account."
        return
      end

      # Deducting from user balance and add to stokvel balance
      @current_user.balance -= @contribution.amount
      @stokvel.balance += @contribution.amount

      if @contribution.save && @stokvel.save && @current_user.save
        flash[:notice] = "Contribution was successfully made using user balance."
        redirect_to stokvel_contribution_path(@stokvel, @contribution), notice: "Contribution was successfully made using user balance."
      else
        puts @contribution.errors.full_messages
        render :new
      end
    elsif payment_method == 'card'
      # integrate with a payment gateway here
      @stokvel.balance += @contribution.amount
      if @contribution.save && @stokvel.save
        flash[:notice] = "Contribution was successfully made using card."
        redirect_to stokvel_contribution_path(@stokvel, @contribution), notice: "Contribution was successfully made using card."
      else
        puts @contribution.errors.full_messages
        render :new
      end
    else
      flash.now[:alert] = "Please select a payment method."
      render :new
    end
  end

  private
  def contribution_params
    params.require(:contribution).permit(:contribution_amount, :user_id, :date, :member_id, :payment_method)
  end
end
