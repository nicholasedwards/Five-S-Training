require 'rails_helper'
include SessionsHelper

RSpec.describe AccountActivationsController, type: :controller do

  it "automatically authenticates a user upon account activation" do
  	valid_user = FactoryGirl.create(:user, activated: false)
    expect(logged_in?).to be_falsy
    get :edit, { id: valid_user.activation_token, email: valid_user.email }
    expect(logged_in?).to be_truthy
  end

end
