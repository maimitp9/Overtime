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
      it 'can not valid without overtime_request' do
        post.overtime_request = nil
        expect(post).to validate_presence_of(:overtime_request)
      end
      it 'overtime_request value should be greatee then 0.0' do
        post.overtime_request = 0.0
        should validate_numericality_of(:overtime_request).is_greater_than(0.0)
      end
    end
  end

  describe "ActiveRecord Accosiation" do
    let(:post) { create(:post) }
    it { expect(post).to belong_to(:user) }
  end

  describe "ActiveRecord scope" do
    5.times do |i|
      let!("post_#{i}".to_sym) { create(:post) }
    end

    before do
      post_1.approved!
      post_2.approved!
      post_3.rejected!
      post_4.rejected!
    end

    it "approved scope" do
      expect(Post.approved.count).to eq 2
    end

    it "rejected scope" do
      expect(Post.rejected.count).to eq 2
    end

    it "submitted scope" do
      expect(Post.submitted.count).to eq 1
    end
  end
end
