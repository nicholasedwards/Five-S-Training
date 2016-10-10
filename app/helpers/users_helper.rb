module UsersHelper

  def store_errors_in_session_hash
  	session[:errors] = @user.errors.full_messages
  end

  def log_out_and_delete_current_user
  	user_id = session[:user_id]
    log_out
    User.find(user_id).destroy
  end

end