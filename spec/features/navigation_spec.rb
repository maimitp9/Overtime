require "rails_helper"

describe "navigation" do
  it "unauthenticated user" do
    visit root_path
    expect(page).to have_content("Log in")
    expect(page).to_not have_content(/Home | 'New Entry' | Options/)
  end

  describe "regular user" do
    let(:user) { create(:user) }
    
    before do
      login_as(user)
    end

    context "navbar" do
      it "regular user navbar" do
        visit root_path
        expect(page).to_not have_content(admin_root_path)
      end
    end
  end

  describe "admin user" do
    let(:admin_user) { create(:admin_user) }
    
    before do
      login_as(admin_user)
    end

    context "navbar" do
      it "regular user navbar" do
        visit root_path
        expect(page).to have_content("Admin Dashboard")
      end
    end
  end
end
