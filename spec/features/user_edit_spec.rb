require 'rails_helper'

RSpec.describe "User Editing" do

  let(:user) { FactoryGirl.create(:user) }

  it "requires the user to be authenticated in order to edit their profile" do
  	log_in_with(user.email, user.password)
  	click_on('Logout')
  	visit edit_user_path(user)
  	expect(page).to have_current_path(login_path)
  end

  it "allows an authenticated user to edit their profile" do
  	log_in_with(user.email, user.password)
  	click_on('Update Profile')
  	fill_in 'Email', with: "new_email@gmail.com"
  	fill_in 'Password', with: "new_password"
  	fill_in 'Password Confirmation', with: "new_password"
  	click_on('Update Profile!')
  	expect(page).to have_content("success")
  	expect(page).to have_current_path(lessons_path)
  end

  it "displays an error message and renders the user edit template in the case of an unsuccessful profile update" do
  	log_in_with(user.email, user.password)
  	click_on('Update Profile')
  	fill_in 'Email', with: " "
  	fill_in 'Password', with: " "
  	fill_in 'Password Confirmation', with: " "
  	click_on('Update Profile!')
  	expect(page).to have_content("error")
  	expect(page).to have_current_path(edit_user_path(user))
  end

end