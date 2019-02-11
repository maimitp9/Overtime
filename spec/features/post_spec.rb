require 'rails_helper'

describe "navigate" do
  before do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end
  describe "index" do
    before do
      visit posts_path
    end
    it "can reached successfully" do
      expect(page.status_code).to eq(200)
    end

    it "has a title of Posts" do 
      expect(page).to have_content(/Posts/)
    end

    it "has a list of posts" do
      post1 = FactoryBot.create(:post)
      post2 = FactoryBot.create(:second_post)
      visit posts_path
      expect(page).to have_content(/#{post1.rational}|#{post2.rational}/)
    end
  end

  describe "creation" do
    before do
      visit new_post_path
    end

    it "can reached to new form successfully" do
      expect(page.status_code).to eq(200)
    end

    it "can be created form a new form page" do
      fill_in "post[date]", with: Date.today
      fill_in "post[rational]", with: "asdfghjkl"
      click_on "Save"

      expect(page).to have_content("asdfghjkl")
    end

    it "will assosciated with user" do
      fill_in "post[date]", with: Date.today
      fill_in "post[rational]", with: "User Associated"
      click_on "Save"

      expect(User.last.posts.last.rational).to eq("User Associated")
    end
  end
end
