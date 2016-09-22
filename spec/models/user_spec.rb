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

end