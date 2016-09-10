require 'rails_helper'

RSpec.describe Lesson do
  
  let(:lesson) { FactoryGirl.build_stubbed(:lesson) }

  it "has two attributes: title and content" do
    expect(lesson).to respond_to(:title)
    expect(lesson).to respond_to(:content)
  end

  it "must have a title attribute present" do
  	lesson_invalid_title = FactoryGirl.build(:lesson, title: nil)
  	expect(lesson_invalid_title).not_to be_valid
  	lesson_invalid_title = FactoryGirl.build(:lesson, title: "  ")
  	expect(lesson_invalid_title).not_to be_valid
  end

  it "must have a content attribute present" do
  	lesson_invalid_content = FactoryGirl.build(:lesson, content: nil)
  	expect(lesson_invalid_content).not_to be_valid
  	lesson_invalid_content = FactoryGirl.build(:lesson, content: "  ")
  	expect(lesson_invalid_content).not_to be_valid
  end

end
