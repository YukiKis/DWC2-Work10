class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params.merge(user_id: current_user.id))
    else
      flash[:alert] = "You could not send a message."
    end
    redirect_to room_path(@message.room_id)
  end

  private
    def message_params
      params.require(:message).permit(:user_id, :room_id, :content)
    end
end
