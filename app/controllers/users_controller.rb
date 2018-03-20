class UsersController < ApplicationController
  def new
    @user=User.new
    @user.save
  end

  def show
    @old_post=Post.where(user_id: current_user.id)
  end

  def edit
    @user=User.new
  end

  def create
    @user=User.create(user_params)
    @user.save
    flash[:welcome] = "---------Welcome to the site ! please sign in now---------" if @user.save
    if @user.errors.full_messages.any?  
      @user.errors.full_messages.each do |error_message| 
      flash[:fname]= "* first name "+ error_message.downcase.split.drop(1).join(' ') if error_message.include? "Fname"
      flash[:lname]= "* last name "+ error_message.downcase.split.drop(1).join(' ') if error_message.include? "Lname"
      flash[:uname]= "* username "+ error_message.downcase.split.drop(1).join(' ')  if error_message.include? "Uname"
      flash[:password]= "* password "+ error_message.downcase.split.drop(2).join(' ')  if error_message.include? "Password"
      flash[:password_confirmation]= "* password "+ error_message.downcase.split.drop(2).join(' ')  if error_message.include? "Password"
      flash[:email]= "* " + error_message.downcase if error_message.include? "Email"
      flash[:location]= "* " + error_message.downcase if error_message.include? "Location"
      flash[:avatar]= "* " + error_message.downcase if error_message.include? "Avatar"

      end   
    end
  redirect_to :back
  end

  def update
    @user=current_user
    if @user.update_attributes(user_params)
      flash[:update]="*************** Update Succeed ***************"
    else
    #if @user.errors.full_messages.any?  
      @user.errors.full_messages.each do |error_message| 
      flash[:fname]= "* first name "+ error_message.downcase.split.drop(1).join(' ') if error_message.include? "Fname"
      flash[:lname]= "* last name "+ error_message.downcase.split.drop(1).join(' ') if error_message.include? "Lname"
      flash[:uname]= "* username "+ error_message.downcase.split.drop(1).join(' ')  if error_message.include? "Uname"
      flash[:password]= "* password "+ error_message.downcase.split.drop(2).join(' ')  if error_message.include? "Password"
      flash[:password_confirmation]= "* password "+ error_message.downcase.split.drop(2).join(' ')  if error_message.include? "Password"
      flash[:email]= "* " + error_message.downcase if error_message.include? "Email"
      flash[:location]= "* " + error_message.downcase if error_message.include? "Location"
      end   
    end
    redirect_to :back
  end

  def destroy
    User.destroy(current_user.id)
    session[:id]=nil
    flash[:welcome]="Your Account has beeen Deleted"
    redirect_to new_user_path
  end
  private
  
  def user_params
    params.require(:user).permit(:fname, :lname, :uname, :email, :password, :password_confirmation, :location, :avatar)
  end
end
