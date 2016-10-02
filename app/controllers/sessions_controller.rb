class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	  if user && user.authenticate(params[:session][:password])
  	  	session[:user_id] = user.id
  	  	flash[:success] = "Login was successful!"
        redirect_to lessons_path
      else
      	flash[:danger] = "Invalid email/password combination."
      	redirect_to login_path
      end
  end

end
