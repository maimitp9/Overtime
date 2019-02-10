require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creation" do
    before do
      @user = User.create(email: 'test@gmail.com', password: '123456', password_confirmation: '123456',
        first_name: 'Maimit', last_name: 'Patel')
      login_as(@user, :scope => :user)
      @post = Post.create(date: Date.today, rational: 'asdfghjkl', user_id: @user.id)
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
