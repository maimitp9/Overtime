require 'rails_helper'

describe "navigate" do
  describe "index" do
    it "can reached successfully" do
      visit posts_path
      expect(page.status_code).to eq(200)
    end

    it "has a title of Posts" do
      visit posts_path
      expect(page).to have_content(/Posts/)
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
  end
end
