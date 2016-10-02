class UsersController < ApplicationController
include UsersHelper

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
  	if @user.save
  	  flash[:success] = "You have successfully signed up!"
      redirect_to lessons_path
  	else
      store_errors_in_session_hash
      redirect_to signup_path
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
