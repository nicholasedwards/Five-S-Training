require 'rails_helper'

RSpec.describe "User Editing" do

  let(:user) { FactoryGirl.create(:user) }

  it "requires the user to be logged in in order to edit their profile" do
  	log_in_with(user.email, user.password)
  	click_on('Logout')
  	visit edit_user_path(user)
  	expect(page).to have_current_path(login_path)
  end

end