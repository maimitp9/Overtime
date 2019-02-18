require "rails_helper"

describe "navigate" do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as(admin_user)
  end

  describe "edit post" do
    let(:post) { create(:post) }
    context "admin user" do
      it "has the status that can be editable on the form" do
        visit edit_post_path(post)

        choose("post_status_approved")
        click_on("Save")
        expect(post.reload.status).to eq("approved")
      end
    end

    context "regular user" do
      let(:user) { create(:user) }
      it "can't edit the status" do
        logout(admin_user)
        login_as(user)

        visit edit_post_path(post)
        expect(page).to_not have_content("Approved")
      end
    end
  end
end
