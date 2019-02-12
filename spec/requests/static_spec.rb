require 'rails_helper'

describe "navigate", type: :request do
  describe "hompage" do
    describe "Unauthenticated User" do
      it "redirect to login page" do
        get root_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "Authenticated User" do
      let(:user) { create(:user) }      
      it "can be reached successfully" do
        sign_in(user)
        get root_path
        expect(response).to render_template(:homepage)
        expect(response.body).to include("Home")
      end
    end    
  end
end