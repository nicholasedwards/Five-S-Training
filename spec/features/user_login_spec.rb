require 'rails_helper'

RSpec.describe 'User Login' do 

  it "redirects to the signup page when the 'Sign up now!' link is clicked" do
  	visit login_path
  	click_on('Sign up now!')
  	expect(page).to have_current_path(signup_path)
  end
	
end