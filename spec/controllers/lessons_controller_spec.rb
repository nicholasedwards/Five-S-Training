require 'rails_helper'

RSpec.describe LessonsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do

      # The lessons index action tries to access a current user via the session variable.
      # In order to provide that data, here we instantiate a user and put its id in the session variable.
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id


      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
