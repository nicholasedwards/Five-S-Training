require 'rails_helper'

RSpec.describe LessonCompletion do 

  let(:user) { FactoryGirl.create(:user) }
  let(:lesson) { FactoryGirl.create(:lesson) }

  it "validates for uniqueness of a lesson completion" do
    user.completed_lessons << lesson
    begin
      user.completed_lessons << lesson
      break
    rescue
      expect(user.completed_lessons.count).to eq(1)
    end
  end
	
end