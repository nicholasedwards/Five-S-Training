require 'rails_helper'

RSpec.describe User do 

  it "has two ActiveRecord attributes: email and password_digest" do
    user = FactoryGirl.build_stubbed(:user)
    expect(user).to respond_to(:email)
    expect(user).to respond_to(:password_digest)
  end

end