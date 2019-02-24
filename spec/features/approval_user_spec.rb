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
    context "can edit post" do
      it "choose approved status on the edit form" do
        choose("post_status_approved")
        click_on("Save")
        expect(post.reload.status).to eq("approved")
      end

      it "choose rejected status on the edit form" do
        choose("post_status_rejected")
        click_on("Save")
        expect(post.reload.status).to eq("rejected")
      end

      it "choose submited status on the edit form" do
        choose("post_status_submitted")
        click_on("Save")
        expect(post.reload.status).to eq("submitted")
      end
    end
    context "can reached to new post form" do
      before do
        visit new_post_path
        fill_in "post[date]", with: Date.today
        fill_in "post[rational]", with: "qwertyuiop"
      end

      it "render new post form successfully" do
        expect(page).to have_content("Approved")
      end
      it "choose approved  status on the new form" do
        choose("post_status_approved")
        click_on("Save")
        expect(page).to have_content("qwertyuiop")
      end

      it "choose rejected status on the new form" do
        choose("post_status_rejected")
        click_on("Save")
        expect(page).to have_content("qwertyuiop")
      end

      it "choose submited status on the new form" do
        choose("post_status_submitted")
        click_on("Save")
        expect(page).to have_content("qwertyuiop")
      end
    end
  end

  context "regular user" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    before do
      logout(admin_user)
      login_as(user)
    end
    it "can't edit the post of other user" do
      visit edit_post_path(post)
      expect(current_path).to eq(root_path)
    end

    it "can't edit the post by the creator once it is approved" do
      post.user_id = user.id
      post.approved!
      visit edit_post_path(post)
      expect(current_path).to eq(root_path)
    end
  end

  # context "regular--- user" do
  #   let(:user) { create(:user) }
  #   let(:post) { create(:post, user: user) }

  #   before do
  #     logout(admin_user)
  #     login_as(user)
  #     post.approved!
  #   end
  # end
end
