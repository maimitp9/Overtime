require 'rails_helper'

RSpec.describe Post, type: :model do
  it "has_valid_factory" do
    expect(build(:post)).to be_valid
  end

  describe "Activerecord Validation" do
    context "requred fields" do
      let(:post) { build(:post) }
      it "can't valid without date" do
        post.date = nil
        expect(post).to validate_presence_of(:date)
      end
      it "can't valid without rational" do
        post.rational = nil
        expect(post).to validate_presence_of(:rational)
      end
    end
  end

  describe "ActiveRecord Validation" do
    let(:post) { create(:post) }
    it { expect(post).to belong_to(:user) }
  end
end
