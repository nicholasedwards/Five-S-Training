require 'rails_helper'

RSpec.describe 'Lessons' do

  let(:user) { FactoryGirl.create(:user) }
  let!(:lesson_1) { FactoryGirl.create(:lesson, title: "Lesson Factory Title 1") }
  let!(:lesson_2) { FactoryGirl.create(:lesson, title: "Lesson Factory Title 2") }
  let!(:lesson_3) { FactoryGirl.create(:lesson, title: "Lesson Factory Title 3") }

  it 'shows the lessons index page as the home page for an authenticated user' do
    log_in_with(user.email, user.password)
    click_on "Home"
    expect(page).to have_current_path(lessons_path)
  end

  it 'shows a new user several incomplete lessons, one of which is an introductory lesson' do
  	sign_up_as("valid@example.com", "va1id_P@ssw0rd", "va1id_P@ssw0rd")
    expect(page).to have_content(lesson_1.title)
    expect(page).to have_content(lesson_2.title)
    expect(page).to have_selector("#next-lesson", text: "Click to start this lesson!")
  end

  it 'shows both complete and incomplete lessons' do
    log_in_with(user.email, user.password)
    user.lesson_completions.create(lesson_id: lesson_1.id)
    click_on "Home"
    expect(page).to have_selector(".completed-lesson", text: "Lesson completed")
    expect(page).to have_selector("#next-lesson", text: "Click to start this lesson!")
    expect(page).to have_selector(".incomplete-lesson", text: "Lesson not yet completed")
  end  

end