module UsersHelper

  def store_errors_in_session_hash
  	session[:errors] = @user.errors.full_messages
  end

end
