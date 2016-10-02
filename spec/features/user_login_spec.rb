require 'rails_helper'

RSpec.describe 'User Login' do 

  it "redirects to the signup page when the 'Sign up now!' link is clicked" do
  	visit login_path
  	click_on('Sign up now!')
  	expect(page).to have_current_path(signup_path)
  end
	
  it "re-renders the login page after submission of invalid login information" do
  	visit login_path
  	fill_in "Email", with: " "
  	fill_in "Password", with: " "
    click_on "Log in!"
    expect(page).to have_content("Invalid")
    expect(page).to have_current_path(login_path)
  end

  it "renders the lessons index page after submission of valid login information" do
    valid_user = FactoryGirl.create(:user)
  	visit login_path
  	fill_in "Email", with: valid_user.email
  	fill_in "Password", with: valid_user.password
  	click_on "Log in!"
    expect(page).to have_content("successful")
  	expect(page).to have_current_path(lessons_path)
  end
	
end