class ContributionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @stokvel = Stokvel.find(params[:stokvel_id])
    @contributions = @stokvel.contributions.order(created_at: :desc)
    @members = @stokvel.members
    @last_contribution = {}
    @last_deposits = {}

    @members.each do |member|
      last_contribution = member.contributions.order(created_at: :desc).first
      if last_contribution
        @last_contribution[member.id] = { date: last_contribution.created_at.strftime('%d/%m/%Y'), amount: last_contribution.contribution_amount }
        @last_deposits[member.id] = { contribution_amount: last_contribution.contribution_amount }
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

  def create
    @current_user = current_user
    @stokvel = Stokvel.find(params[:stokvel_id])
    @contribution = @stokvel.contributions.new(contribution_params)
    @contribution.user = current_user

    member = @stokvel.members.find_by(user_id: current_user.id)
    if member.nil?
      redirect_to root_path, alert: "You are not a member of this Stokvel."
      return
    end
    @contribution.member = member
    @contribution.date = Date.today
    @contribution.amount = contribution_params[:contribution_amount].to_d
    @stokvel.balance ||= 0
    @stokvel.balance += @contribution.amount
    if @contribution.save && @stokvel.save
      redirect_to stokvel_contribution_path(@stokvel, @contribution), notice: "Contribution was successfully ."
    else
      puts @contribution.errors.full_messages # Log the errors to the console
      render :new
    end
  end

  private
  def contribution_params
    params.require(:contribution).permit(:contribution_amount, :user_id, :date, :member_id)
  end
end
