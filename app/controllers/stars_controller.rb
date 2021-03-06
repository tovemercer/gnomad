class StarsController < ApplicationController

  def create
    recipient = User.find(star_params[:recipient_id])
    current_user.send_star(recipient)
    render json: {count: recipient.star_count}
  end

  def destroy
    recipient = User.find(star_params[:recipient_id])
    if current_user.starred?(recipient)
      star = recipient.received_stars.where(sender: current_user).first
      Star.destroy(star.id)
    end
    render json: {count: recipient.star_count}
  end

  private
    def star_params
      params.require(:star).permit(:recipient_id)
    end
end
