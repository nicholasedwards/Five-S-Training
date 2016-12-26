class AccountActivationsController < ApplicationController
include SessionsHelper

  def edit	
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.activate?(params[:id])
      user.update_attribute(:activated, true)
      log_in user
      flash[:success] = "Your account has been successfully activated! Welcome to 5S Training. When you read one of the lessons below, your progress will be recorded. Please click on the first lesson below to get started!"
      redirect_to lessons_path
    else
      flash[:danger] = "Sorry! That was an invalid activation link."
      redirect_to login_path
    end
  end

end
