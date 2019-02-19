require "rails_helper"

describe "navigate" do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as(admin_user)
  end

  describe "admin user" do
    let(:post) { create(:post) }
    before do
      visit edit_post_path(post)
    end
    context "edit post" do
      it "choose approved status on the form" do
        choose("post_status_approved")
        click_on("Save")
        expect(post.reload.status).to eq("approved")
      end

      it "choose rejected status on the form" do
        choose("post_status_rejected")
        click_on("Save")
        expect(post.reload.status).to eq("rejected")
      end

      it "choose submited status on the form" do
        choose("post_status_submitted")
        click_on("Save")
        expect(post.reload.status).to eq("submitted")
      end
    end
    context "New post" do
      before do
        visit new_post_path
        fill_in "post[date]", with: Date.today
        fill_in "post[rational]", with: "qwertyuiop"
      end

      it "rrender new form" do
        expect(page).to have_content("Approved")
      end
      it "choose approved  status on the form" do
        choose("post_status_approved")
        click_on("Save")
        expect(page).to have_content("qwertyuiop")
      end

      it "choose rejected status on the form" do
        choose("post_status_rejected")
        click_on("Save")
        expect(page).to have_content("qwertyuiop")
      end

      it "choose submited status on the form" do
        choose("post_status_submitted")
        click_on("Save")
        expect(page).to have_content("qwertyuiop")
      end
    end
  end

  context "regular user" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    it "can't edit the status" do
      logout(admin_user)
      login_as(user)

      visit edit_post_path(post)
      expect(page).to_not have_content(/Submitted | Approved | Rejected/)
    end
  end
end
