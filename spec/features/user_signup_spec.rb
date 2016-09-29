require 'rails_helper'

RSpec.describe 'User Signup' do 

  it "redirects to the user signup page from the Home page" do
  	visit(root_path)
  	click_on('Sign up!')
    expect(page).to have_current_path(new_user_path)
  end

  it "re-renders the signup page after submission of invalid signup information" do
    visit(new_user_path)
    fill_in "Email", with: " "
    fill_in "Password", with: " "
    fill_in "Password Confirmation", with: " "

    # Capybara's click_on method will submit an asynchronous request, which would introduce a problem
    # if we were to test for a change in User.count like this:
    # expect( click_on "Sign up!" ).to change{User.count}.by(0)
    # In that case, Capybara might receive a response to its asynchronous request before ActiveRecord has
    # finished saving a possible new User to the database and checking for it with User.count.
    # So, alternatively, we can just check User.count, call click_on "Sign up!", and check User.count again after
    # we know that Capybara's asynchronous request from click_on has returned a response. Capybara will have
    # received a response by the time the next RSpec or Capybara method is called, so an appropriate time to check 
    # if User.count has changed would be after the method that follows the click_on method.

    user_count_before_submission = User.count
    click_on "Sign up!"
    expect(page).to have_content("error")
    user_count_after_submission = User.count
    expect(user_count_before_submission).to eql(user_count_after_submission)
    expect(page).to have_current_path(new_user_path)
  end

  it "creates a new user and renders the lessons index page after submission of valid signup information" do
  	visit(new_user_path)
  	fill_in "Email", with: "valid@example.com"
  	fill_in "Password", with: "f00bAr!"
    fill_in "Password Confirmation", with: "f00bAr!" 
    user_count_before_submission = User.count
    click_on "Sign up!"
    expect(page).to have_content("successful")
    user_count_after_submission = User.count
    expect(user_count_before_submission).not_to eql(user_count_after_submission)
    expect(page).to have_current_path(lessons_path)	
  end
	
end