require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "Login" do

    it "does not log the user in when invalid login information is provided" do
  	  post :create, session: {email: " ", password: " "}
      expect(is_logged_in?).to be_falsy
    end

    it "logs the user in when valid login information is provided" do
      valid_user = FactoryGirl.create(:user)
  	  post :create, session: {email: valid_user.email, password: valid_user.password}
      expect(is_logged_in?).to be_truthy
    end

  end

end
