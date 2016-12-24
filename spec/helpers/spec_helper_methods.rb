module Helpers

  def sign_up_as(email, password, password_confirmation) 
  	visit(signup_path)
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password Confirmation", with: password_confirmation
    click_on "Sign up!"
  end

  def logged_in?
  	!session[:user_id].nil?
  end

  def log_in_with(email, password)
  	visit login_path
  	fill_in "Email", with: email
  	fill_in "Password", with: password
    click_on "Log in!"
  end

end
