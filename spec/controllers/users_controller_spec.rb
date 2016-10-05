require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "Automatic Login at Signup" do

  it "automatically logs in a new user upon signup" do
    valid_user = FactoryGirl.build(:user)
    expect(logged_in?).to be_falsy
    post :create, user: { email: valid_user.email, password: valid_user.password, password_confirmation: valid_user.password_confirmation }    
    expect(logged_in?).to be_truthy
  end

  end

end
