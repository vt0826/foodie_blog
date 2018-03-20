class FollowsController < ApplicationController
  def create
    @follow=Follow.create(follow_params)
    redirect_to :back
  end

  def destroy
    @delete_follow_id=Follow.where(follower_id: params[:follower_id], followee_id: params[:followee_id]).first.id 
    Follow.destroy(@delete_follow_id)
    redirect_to :back
  end

  private
  
  def follow_params
    params.require(:follow).permit(:followee_id, :follower_id)
  end
end
