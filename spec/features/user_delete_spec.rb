require 'rails_helper'

RSpec.describe "User Deleting" do

  let(:user)  { FactoryGirl.create(:user) }
	
  it "allows an authenticated user to delete their profile" do
  	log_in_with(user.email, user.password)
  	user_count_before_destroy = User.count
  	click_on('Delete Profile')
  	expect(page).to have_current_path(confirm_deletion_path)
  	click_on('Yes. Delete my Account.')
    user_count_after_destroy = User.count
    expect(user_count_after_destroy).to eql(user_count_before_destroy - 1)
    expect(page).to have_content('deleted')
    expect(page).to have_current_path(root_path)
  end

end