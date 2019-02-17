require "rails_helper"

describe "navigate" do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as(admin_user)
  end

  describe "edit post" do
    let(:post) { create(:post) }
    it "has the status than can be editable on the form" do
      visit edit_post_path(post)

      choose("post_status_approved")
      click_on("Save")
      expect(post.reload.status).to eq("approved")
    end
  end

end
