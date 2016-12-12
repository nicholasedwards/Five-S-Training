require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "Authentication" do

    it "does not log the user in when invalid authentication credentials are provided" do
  	  post :create, session: {email: " ", password: " "}
      expect(logged_in?).to be_falsy
    end

    it "logs the user in when valid authentication credentials are provided" do
      valid_user = FactoryGirl.create(:user)
  	  post :create, session: {email: valid_user.email, password: valid_user.password}
      expect(logged_in?).to be_truthy
    end

    it "logs the user out when a DELETE request is sent to sessions#destroy" do
      valid_user = FactoryGirl.create(:user)
      post :create, session: {email: valid_user.email, password: valid_user.password}
      expect(logged_in?).to be_truthy
      delete :destroy
      expect(logged_in?).to be_falsy
    end

  end

end
