require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  
  describe "creation" do
    it "can create user" do
      expect(@user).to be_valid
    end

    it "can't be valid without first_name, last_name" do
      @user.first_name = nil
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
  end

  describe "custome methods" do
    it ".full_name" do
      expect(@user.full_name).to eql("MAIMIT PATEL")
    end
  end
end
