require 'rails_helper'

RSpec.describe 'User Authentication' do 

  let(:valid_user) { FactoryGirl.create(:user) }

  it "redirects to the signup page when the 'Sign up now!' link is clicked" do
    visit login_path
    click_on('Sign up now!')
    expect(page).to have_current_path(signup_path)
  end
  
  it "re-renders the login page after submission of invalid login information" do
    log_in_with(" ", " ")
    expect(page).to have_content("Invalid")
    expect(page).to have_current_path(login_path)
  end

  it "renders the lessons index page after submission of valid login information" do
    log_in_with(valid_user.email, valid_user.password)
    expect(page).to have_content("successful")
    expect(page).to have_current_path(lessons_path)
  end

  it "displays a login link for users who are not logged in, and a logout link for users who are logged in" do
    visit root_path
    expect(page).to have_link('Login', href: '/login')
    expect(page).not_to have_link('Logout', href: '/logout')

    log_in_with(valid_user.email, valid_user.password)
    expect(page).to have_link('Logout', href: '/logout')
    expect(page).not_to have_link('Login', href: '/login')

    click_on('Logout')
    expect(page).to have_link('Login', href: '/login')
    expect(page).not_to have_link('Logout', href: '/logout')
  end
  
end