require "rails_helper"

describe "AdminUser", type: :request do
  it "can't reached to root page without login" do
    get "/admin"
    expect(response).to redirect_to new_user_session_path
  end

  describe "non admin user" do
    let(:user) { create(:user) }
    
    it "can't reached to an admin page" do
      sign_in(user)
      get "/admin"
      expect(response).to redirect_to root_path
    end
  end

  describe "an admin user" do
    let(:admin_user) { create(:admin_user) }
    
    it "can reched to an admin page" do
      sign_in(admin_user)
      get "/admin"
      expect(response.body).to include(admin_root_path)
    end
  end
end