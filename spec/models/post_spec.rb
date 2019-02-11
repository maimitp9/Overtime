require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creation" do
    before do
      user = FactoryBot.create(:user)
      login_as(user, :scope => :user)
      @post = FactoryBot.create(:post)
    end

    it "can create post" do
      expect(@post).to  be_valid
    end

    it "can't valid without date and reational" do
      @post.date = nil
      @post.rational = nil
      expect(@post).to_not be_valid
    end
  end
end
