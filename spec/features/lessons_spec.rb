require 'rails_helper'

RSpec.describe 'Lessons' do

  let(:user) { FactoryGirl.create(:user) }

  it 'shows the lessons index page as the home page for an authenticated user' do
    log_in_with(user.email, user.password)
    click_on "Home"
    expect(page).to have_current_path(lessons_path)
  end
	
end