# app/controllers/stokvel_users_controller.rb
class StokvelUsersController < ApplicationController
  def index
    @stokvel = Stokvel.find(params[:stokvel_id])
    @users = User.where.not(id: @stokvel.members.pluck(:user_id))

    if params[:query].present?
      # @stokvel = Stokvel.find(params[:stokvel_id])
      @users = @users.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.text { render partial: "members/users_list", locals: { users: @users, stokvel: @stokvel }, formats: [:html] }
    end
  end

end
end
