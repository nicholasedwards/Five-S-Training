require 'rails_helper'

RSpec.describe User do 

  it "has two ActiveRecord attributes: email and password_digest" do
    user = FactoryGirl.build_stubbed(:user)
    expect(user).to respond_to(:email)
    expect(user).to respond_to(:password_digest)
  end

  it "validates presence of email attribute" do
  	user_no_email = FactoryGirl.build_stubbed(:user, email: nil)
  	expect(user_no_email).not_to be_valid

  	user_no_email = FactoryGirl.build_stubbed(:user, email: " ")
  	expect(user_no_email).not_to be_valid
  end

  it "validates for a properly formatted email address" do
    user_invalid_email = FactoryGirl.build_stubbed(:user, email: "invalid")
    expect(user_invalid_email).not_to be_valid

    user_invalid_email = FactoryGirl.build_stubbed(:user, email: "invalid@")
    expect(user_invalid_email).not_to be_valid

    user_invalid_email = FactoryGirl.build_stubbed(:user, email: "invalid@com")
    expect(user_invalid_email).not_to be_valid

    user_invalid_email = FactoryGirl.build_stubbed(:user, email: "invalid@gmail.")
    expect(user_invalid_email).not_to be_valid

    user_valid_email = FactoryGirl.build_stubbed(:user, email: "valid@gmail.com")
    expect(user_valid_email).to be_valid
  end

end