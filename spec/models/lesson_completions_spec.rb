require 'rails_helper'

RSpec.describe LessonCompletion do

  let(:user) { FactoryGirl.create(:user) }
  let(:lesson) { FactoryGirl.create(:lesson) }

  it "validates for uniqueness of a lesson completion" do
    user.completed_lessons << lesson
    expect {user.completed_lessons << lesson}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "destroys associated lesson completions when a user is destroyed" do
    user.completed_lessons << lesson
    user.destroy
    expect(LessonCompletion.count).to eq(0)
  end

  it "destroys associated lesson completions when a lesson is destroyed" do
    lesson.users_who_completed_this_lesson << user
    lesson.destroy
    expect(LessonCompletion.count).to eq(0)
  end

end
