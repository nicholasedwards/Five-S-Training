require 'rails_helper'

RSpec.describe 'User Signup' do 

  it "redirects to the user signup page from the Home page" do
  	visit(root_path)
  	click_on('Sign up!')
    expect(page).to have_current_path(new_user_path)
  end
	
end