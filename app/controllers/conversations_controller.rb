class ConversationsController < ApplicationController

  def index
    render json: Conversation.where("user1_id = ? OR user2_id = ?", @current_user.id, @current_user.id), current_user: @current_user, status: :ok
  end

  def update
    if (@conversation = Conversation.find_by_id(params[:id]))
      @conversation.update(location: params[:location], datetime: Time.at(params[:datetime] / 1000))

      if @conversation.valid?
        render status: :no_content
      else
        render json: @conversation.errors.messages, status: :conflict
      end
    else
      render status: :conflict
    end
  end

end
