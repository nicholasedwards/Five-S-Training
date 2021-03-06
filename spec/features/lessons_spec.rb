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
    log_in_with(user.email, user.password)
    expect(page).to have_content(lesson_1.title)
    expect(page).to have_content(lesson_2.title)
    expect(page).to have_title("Home")
    expect(page).to have_selector("#next-lesson", text: "Click to start this lesson!")
  end  

  it 'shows complete lessons, followed by the next lesson, followed by incomplete lessons' do
    log_in_with(user.email, user.password)
    user.lesson_completions.create(lesson_id: lesson_1.id)
    click_on "Home"

    expect(page).to have_selector(".completed-lesson", text: "Lesson completed")
    expect("Lesson completed").to appear_in_page_before("Click to start this lesson!")

    expect(page).to have_selector("#next-lesson", text: "Click to start this lesson!")
    expect("Click to start this lesson!").to appear_in_page_before("Lesson not yet completed")
    
    expect(page).to have_selector(".incomplete-lesson", text: "Lesson not yet completed")
  end 

  it 'allows a user to complete a lesson, followed by a redirect to the lessons index page' do
    log_in_with(user.email, user.password)
    click_on "#{lesson_1.title}"
    expect(page).to have_current_path(lesson_path(lesson_1))
    click_on "I have read this lesson and I understand it!"
    expect(page).to have_content("Great job! You have completed #{lesson_1.title}.")
    expect(page).to have_current_path(lessons_path)
    expect(lesson_1.users_who_completed_this_lesson).to include(user)
    expect(user.completed_lessons).to include(lesson_1)
  end

  it 'displays lesson content and page title' do
    log_in_with(user.email, user.password)
    click_on "#{lesson_1.title}"
    expect(page).to have_content(lesson_1.content)
    expect(page).to have_title(lesson_1.title)
  end

  it 'displays a link to the lessons index from a lesson that has already been completed' do
    log_in_with(user.email, user.password)
    click_on "#{lesson_1.title}"
    click_on "I have read this lesson and I understand it!"
    click_on "#{lesson_1.title}"
    click_on "Go back to home page"
    expect(page).to have_current_path(lessons_path)  
  end

  it 'orders the lessons index by id, even when a lesson has been updated' do
    # I found a bug in production where the lessons index would show lessons sorted by the updated_at attribute, instead of by id.
    # However, as of now I have been unsuccessful at replicating this issue in the test environment, where the lessons index collection is reliably sorted by id.
    # This test has been green all along, both before and after a minor change to the lessons controller code, but it still should prevent regressions. 
    first_lesson = Lesson.create(title: "Lesson 1 title", content: "Lesson 1 original content")
    second_lesson = Lesson.create(title: "Lesson 2 title", content: "Lesson 2 content")
    first_lesson.content = "Lesson 1 updated content"

    log_in_with(user.email, user.password)
    expect(first_lesson.title).to appear_in_page_before(second_lesson.title)    
  end

  it 'displays a special flash message when all lessons have been completed' do
    log_in_with(user.email, user.password) 
      Lesson.all.each do |lesson|  
        click_on "#{lesson.title}"
        click_on "I have read this lesson and I understand it!"   
      end 
    expect(page).to have_content("You have completed every lesson.")     
  end  

end
