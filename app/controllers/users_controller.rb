class UsersController < ApplicationController
include UsersHelper
include SessionsHelper

before_action :logged_in_user, only: [:edit, :update, :destroy]
before_action :correct_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
  	if @user.save
  	  flash[:success] = "You have successfully signed up!"
      log_in(@user)
      redirect_to lessons_path
  	else
      store_errors_in_session_hash
      redirect_to signup_path
  	end
  end

  def edit
    @user = User.find(params[:id])    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "You have successfully updated your profile!"
      redirect_to lessons_path
    else
      store_errors_in_session_hash
      redirect_to edit_user_path(@user)
    end
  end

  def confirm_deletion
    @user = current_user
  end

  def destroy
    log_out_and_delete_current_user
    flash[:success] = "Your account has been deleted!"
    redirect_to root_path
  end

  private

  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def logged_in_user
    redirect_to login_path if !logged_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end

end
