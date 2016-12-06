require 'rails_helper'

RSpec.describe 'Static Pages' do 

  it "has a Home page, an About page, a Login page, and links between the two" do
    visit(root_path)
    expect(page).to have_selector('#about')
    expect(page).to have_selector('#home')
    expect(page).to have_selector('#login')
    expect(page).to have_title "5S Training | Home"
    click_on('About')
    expect(page).to have_current_path(about_path)
    expect(page).to have_selector('#about')
    expect(page).to have_selector('#home')
    expect(page).to have_selector('#login')    
    expect(page).to have_title "5S Training | About"
    click_on('Login')
    expect(page).to have_current_path(login_path)
    expect(page).to have_selector('#about')
    expect(page).to have_selector('#home')
    expect(page).to have_selector('#login')
    expect(page).to have_title "5S Training | Login"
    click_on('Home')
    expect(page).to have_current_path(root_path)
  end
  
end