class MessagesController < ApplicationController
  def index
    @stokvel = Stokvel.find(params[:stokvel_id])
    @messages = @stokvel.messages
    @message = Message.new
  end

  def create
    @stokvel = Stokvel.find(params[:stokvel_id])
    @message = @stokvel.messages.new(message_params)
    @message.stokvel = @stokvel
    @message.member = Member.find_by(user: current_user, stokvel: @stokvel)

    if @message.save
      StokvelChannel.broadcast_to(
        @stokvel,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.member.user.id
      )
      redirect_to stokvel_messages_path(@stokvel), notice: "Message sent successfully!"
    else
      render "stokvels/show", status: :unprocessable_entity
    end
  end

    private
    def message_params
      params.require(:message).permit(:content)
    end
  end
