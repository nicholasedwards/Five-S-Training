class SessionsController < ApplicationController
include SessionsHelper

  def new
  end

  def create
  	user = find_user_from_login_attempt
  	  if user_exists_and_has_correct_credentials?(user)
  	  	log_in(user)
  	  	flash[:success] = "Login was successful!"
        redirect_to lessons_path
      else
      	flash[:danger] = "Invalid email/password combination."
      	redirect_to login_path
      end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end