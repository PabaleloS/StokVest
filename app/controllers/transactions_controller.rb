class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stokvel, only: [:new, :create]
  before_action :set_member, only: [:new, :create]

  def index
    @member = Member.find(params[:member_id])
    @transactions = @member.transactions
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @member = Member.find(params[:member_id])
    @transaction = @member.transactions.build
  end

  def create
    @member = Member.find(params[:member_id])
    @transaction = @member.transactions.build(transaction_params)
    if @transaction.save
      redirect_to member_transactions_path(@member)
    else
      render 'new'
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to member_transaction_path(@transaction.member, @transaction)
    else
      render 'edit'
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to member_transactions_path(@transaction.member)
  end

  private

  def set_stokvel
    @stokvel = Stokvel.find(params[:stokvel_id])
  end

  def set_member
    @member = @stokvel.members.find_by(user_id: current_user.id)
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :date, :transaction_type)
  end
end
