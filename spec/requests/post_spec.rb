require "rails_helper"

describe "Post Page", type: :request do
  let(:user) { create(:user) }
  describe "Unauthenticated user" do
    it "redirect to login page" do
      get "/posts"
      expect(response).to redirect_to new_user_session_path
    end
  end
end