class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stokvel
  before_action :set_member, only: [:destroy]
  def index
    # Check if the request came from the stokvel show page
    if request.referer != stokvel_url(@stokvel)
      redirect_to stokvel_url(@stokvel), alert: "You can only view members from the stokvel show page."
    else
      # Retrieves members specific to the Stokvel group being viewed
      @members = @stokvel.members.includes(:contributions).order('contributions.created_at DESC')

      # Fetch the last contribution date and amount for each member
      @last_contributions = {}
      @members.each do |member|
        last_contribution = member.contributions.last
        @last_contributions[member.id] = last_contribution ? { date: last_contribution.created_at.to_date, contribution_amount: last_contribution.contribution_amount } : nil
      end
    end
  end

  # show details of a  member of a specific stokvel group
  def show
    @stokvel = Stokvel.find(params[:stokvel_id])
    @member = @stokvel.members.find(params[:id])
    @users_not_in_stokvel = User.where.not(id: @stokvel.members.pluck(:user_id))  # Get users not in the stokvel
  end

  def new
    @stokvel = Stokvel.find(params[:stokvel_id])
    @users_not_in_stokvel = User.where.not(id: @stokvel.members.pluck(:user_id))
  end

  def create
    @stokvel = Stokvel.find(params[:stokvel_id])
    @member = @stokvel.members.new(member_params)
    @member.user = current_user
    if @member.save
      redirect_to @stokvel, notice: "Member was successfully added."
    else
      render :new
    end
  end

  def create_members
    @user_ids = params[:member_ids]
    @stokvel = Stokvel.find(params[:id])
    @user_ids.each do |user_id|
      member = Member.new(user_id: user_id,
                          stokvel_id: @stokvel.id,
                          status: "pending",
                          balance: 0,
                          join_date: Date.today)
    member.save
    end
    redirect_to stokvel_path(params[:id]), notice: "Members were successfully added."
    # redirect_to stokvel_path(params[:stokvel_id]), notice: "Members were successfully added."
  end

  def accepted
    member = Member.find_by(stokvel_id: params[:stokvel_id], user_id: params[:user_id])
    if member
      member.update(status: "accepted")
      redirect_to stokvel_path(params[:stokvel_id]), notice: "Member accepted ."
    else
      redirect_to stokvel_path(params[:stokvel_id]), notice: "Member not found."
    end
  end

  def declined
    member = Member.find_by(user_id: current_user, stokvel_id: params[:id])
    if member
      member.update(status: "declined")
      redirect_to root_path, notice: "User has declined invitation."
    else
      redirect_to root_path, notice: "Member not found."
    end
  end

  def update
    @member = current_user.member.find_by(stokvel_id: params[:stokvel_id])
    if params[:commit] == 'Accept'
      @member.update(status: 'accepted')
      redirect_to stokvel_path(@member.stokvel_id), notice: 'Invitation accepted successfully.'
    elsif params[:commit] == 'Decline'
      @member.update(status: 'declined')
      if @member.update.stokvel.status == 'declined'
        @member.destroy
        redirect_to stokvel_path(@member.stokvel_id), notice: 'Invitation declined and deleted.'
      else
      redirect_to stokvel_path(@member.stokvel_id), notice: 'Invitation declined successfully.'
      end
    end
  end

  def destroy
    @stokvel = Stokvel.find(params[:stokvel_id])
    @member = @stokvel.members.find(params[:id])

    if @member.destroy
      respond_to do |format|
        format.html { redirect_to stokvel_path(@stokvel), notice: 'Member was successfully deleted.' }
        format.js   # This will look for a destroy.js.erb file
      end
    else
      respond_to do |format|
        format.html { redirect_to stokvel_path(@stokvel), alert: 'Failed to delete member.' }
        format.js   # This will look for a destroy.js.erb file
      end
    end
  end

  # def destroy
  #   @member.destroy
  #   redirect_to stokvel_members_path(@stokvel), notice: 'Member was successfully removed.'
  # end

  private
  def set_stokvel
    @stokvel = Stokvel.find_by(id: params[:stokvel_id]) # Use find_by to avoid exceptions
    unless @stokvel
      redirect_to stokvels_path, alert: "Stokvel not found." # Redirect if not found
    end
  end

  def set_member
    @member = @stokvel.members.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:user_id)
  end
end
