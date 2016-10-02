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

  it "displays a login link and no logout link for users who are not logged in" do
    visit root_path
    expect(page).to have_selector('#login')
    expect(page).not_to have_selector('#logout')
  end

  it "displays a logout link and no login link for users who are logged in" do
    valid_user = FactoryGirl.create(:user)
    visit login_path
    fill_in "Email", with: valid_user.email
    fill_in "Password", with: valid_user.password
    click_on "Log in!"
    expect(page).to have_selector('#logout')
    expect(page).not_to have_selector('#login')
  end
	
end