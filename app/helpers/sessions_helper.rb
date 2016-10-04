module SessionsHelper

  def find_user_from_login_attempt
  	User.find_by(email: params[:session][:email])
  end

  def user_exists_and_has_correct_credentials?(user)
    user && user.authenticate(params[:session][:password])
  end

  def log_in(user)
  	session[:user_id] = user.id
  end

  def logged_in?
  	!session[:user_id].nil?
  end

  def log_out
    session.delete(:user_id)    
  end

end
