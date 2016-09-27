class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
  	if @user.save
  	  flash[:success] = "You have successfully signed up!"
      redirect_to @user
  	else
  	  flash[:danger] = "There was an error!"
      redirect_to new_user_path
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
