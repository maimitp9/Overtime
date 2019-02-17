require 'rails_helper'

RSpec.describe User, type: :model do
  it "should be valid factory" do
    expect(build(:user)).to be_valid
  end

  describe "ActiveRecord Validation" do
    context "required fields" do
      let(:user) { build(:user) }
      it "can't save without first_name" do
        user.first_name = nil
        expect(user).to validate_presence_of(:first_name)
      end
      it "can't save without first_name" do
        user.last_name = nil
        expect(user).to validate_presence_of(:last_name)
      end
    end

    context "format validation" do
      let(:user) { build(:user) }
      it "validate email formate" do
        expect(user).to allow_value(Faker::Internet.email).for(:email)
        expect(user).not_to allow_value("ashg22.com").for(:email) 
      end
    end
  end

  describe "ActiveRecord Accosiation" do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    it { expect(user).to have_many(:posts) }
  end

  describe "custome methods" do
    let(:user) { build(:user) }
    it ".full_name" do
      full_name = [user.first_name, user.last_name].join(' ').upcase
      expect(user.full_name).to eql(full_name)
    end
  end
end
