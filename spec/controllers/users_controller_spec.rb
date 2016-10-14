require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "Automatic Authentication at Signup" do

  it "automatically authenticates a new user upon signup" do
    valid_user = FactoryGirl.build(:user)
    expect(logged_in?).to be_falsy
    post :create, user: { email: valid_user.email, password: valid_user.password, password_confirmation: valid_user.password_confirmation }    
    expect(logged_in?).to be_truthy
  end

  end

  describe "User Updating" do

    it "redirects when an unauthenticated client sends a PATCH or PUT request to users#update" do
      expect(logged_in?).to be_falsy
      patch :update, { id: 1 , user: { email: "updated_email_attempt@gmail.com", password: "updated_password_attempt", password_confirmation: "updated_password_attempt" } } 
      expect(response).to redirect_to(login_path)    
      put :update, { id: 1 , user: { email: "updated_email_attempt@gmail.com", password: "updated_password_attempt", password_confirmation: "updated_password_attempt" } }
      expect(response).to redirect_to(login_path)   
    end

    it "redirects when an authenticated user sends a PATCH or PUT request to users#update for a different user" do

    # Create an innocent user who only wants to use the application in peace!
      innocent_user = FactoryGirl.create(:user)   

    # Create a malicious user, and log in as the malicious user
      malicious_user = FactoryGirl.create(:user)
      log_in(malicious_user)   

    # Attempt to update the first user's profile.
      patch :update, { id: innocent_user.id , user: { email: "updated_email_attempt@gmail.com", password: "updated_password_attempt", password_confirmation: "updated_password_attempt" } } 
      expect(response).to redirect_to(root_path)    
      put :update, { id: innocent_user.id , user: { email: "updated_email_attempt@gmail.com", password: "updated_password_attempt", password_confirmation: "updated_password_attempt" } }
      expect(response).to redirect_to(root_path) 

    end  

  end

  describe "User Deleting" do

    it "redirects when an unauthenticated client sends a DELETE request to users#destroy" do
      expect(logged_in?).to be_falsy
      delete :destroy, { id: 1 } 
      expect(response).to redirect_to(login_path) 
    end

    it "redirects and does not delete a user when an authenticated user sends a DELETE request to users#destroy for a different user" do

    # Create an innocent user who only wants to use the application in peace!
      innocent_user = FactoryGirl.create(:user)   

    # Create a malicious user, and log in as the malicious user
      malicious_user = FactoryGirl.create(:user)
      log_in(malicious_user)   

      user_count_before_deletion_attempt = User.count

    # Attempt to update the first user's profile.
      delete :destroy, { id: innocent_user.id  } 
      expect(response).to redirect_to(root_path)   

      user_count_after_deletion_attempt = User.count 

      expect(user_count_after_deletion_attempt).to eql(user_count_before_deletion_attempt)

    end      

  end

end
