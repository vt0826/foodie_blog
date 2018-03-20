class SessionController < ApplicationController
  def create
    @user = User.authenticate(params[:uname], params[:password])
    if @user
      session[:id] = @user.id
      session[:username] = @user.uname
      redirect_to "/"
    else
      flash[:alert] = "********Username / Password incorrect ********"
      redirect_to new_user_path
    end
  end

  def destroy
    session[:id] = nil
    redirect_to "/"
  end
end
