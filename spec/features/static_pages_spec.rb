require 'rails_helper'

RSpec.describe 'Static Pages' do 

  let!(:lesson) { FactoryGirl.create(:lesson) }

  it "has a Home page, an About page, and links between the two" do
  	visit(root_path)
  	expect(page).to have_selector('#about')
    expect(page).to have_selector('#home')
    expect(page).to have_title "5S Training | Home"
    expect(page).to have_content(lesson.title)
  	click_on('About')
  	expect(page).to have_current_path(about_path)
    expect(page).to have_selector('#about')
    expect(page).to have_selector('#home')
    expect(page).to have_title "5S Training | About"
  	click_on('Home')
  	expect(page).to have_current_path(root_path)
  end
	
end