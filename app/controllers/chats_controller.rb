class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    if UserRoom.where(user_id: current_user.id, room_id: params[:chat][:room_id]).present?
      @chat = Chat.create(chat_params.merge(user_id: current_user.id))
      @chats = Room.find(@chat.room_id).chats.all
    else
      flash[:alert] = "You could not send a chat"
    end

  end

  private 
  def chat_params
    params.require(:chat).permit(:user_id, :room_id, :content)
  end
end
