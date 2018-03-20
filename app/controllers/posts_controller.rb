class PostsController < ApplicationController

  def new
    @post=Post.new
    @old_post=Post.where(user_id: current_user.id)
  end

  def index
    @post=Post.order("id").reverse_order.limit(10) 
    @follow=Follow.new
  end
  def create
   @post=Post.create(post_params) 
   redirect_to :back
  end

 private
  
  def post_params
    params.require(:post).permit(:subject, :body, :user_id, :avatar)
  end

end
