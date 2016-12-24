require 'rails_helper'

RSpec.describe 'User Signup' do 

  before(:all) do
    ActionMailer::Base.deliveries.clear
  end

  it "redirects to the user signup page from the Home page" do
  	visit(root_path)
  	click_on('Sign up!')
    expect(page).to have_current_path(signup_path)
  end

  it "re-renders the signup page after submission of invalid signup information" do
    user_count_before_signup = User.count   
    sign_up_as(" ", " ", " ")

    # Capybara's click_on method will submit an asynchronous request, which would introduce a problem
    # if we were to test for a change in User.count like this:
    # expect( click_on "Sign up!" ).to change{User.count}.by(0)
    # In that case, Capybara might receive a response to its asynchronous request before ActiveRecord has
    # finished saving a possible new User to the database and checking for it with User.count.
    # So, alternatively, we can just check User.count, call click_on "Sign up!", and check User.count again after
    # we know that Capybara's asynchronous request from click_on has returned a response. Capybara will have
    # received a response by the time the next RSpec or Capybara method is called, so an appropriate time to check 
    # if User.count has changed would be after the method that follows the click_on method.

    expect(page).to have_content("error")
    user_count_after_signup = User.count
    expect(user_count_before_signup).to eql(user_count_after_signup)
    expect(page).to have_current_path(signup_path)
  end

  it "signs up a new user and activates the account" do
    user_count_before_signup = User.count
    sign_up_as("valid@example.com", "va1id_P@ssw0rd", "va1id_P@ssw0rd")
    user_count_after_signup = User.count
    expect(user_count_after_signup).to eql(user_count_before_signup + 1)
    user = User.last
    expect(page).to have_content("check your email")
    expect(page).to have_current_path(root_path)    
    expect(user).not_to be_activated
    # Try to log in before activation.
    log_in_with("valid@example.com", "va1id_P@ssw0rd")
    expect(page).to have_content("account has not been activated")
    expect(page).to have_current_path(login_path)
    # Try to activate an account with a valid email but invalid token
    visit edit_account_activation_path("invalid token", email: user.email)
    expect(page).to have_content("invalid activation link")
    expect(page).to have_current_path(login_path)    
    # Try to activate an account with a valid token but invalid email
    visit edit_account_activation_path(user.activation_token, email: "invalid email")
    expect(page).to have_content("invalid activation link")
    expect(page).to have_current_path(login_path)    
    # Try to activate an account with a valid token and valid email
    visit edit_account_activation_path(user.activation_token, email: user.email)
    user.reload
    expect(user).to be_activated
    expect(page).to have_content("successfully activated")
    expect(page).to have_current_path(lessons_path) 
  end
	
end
