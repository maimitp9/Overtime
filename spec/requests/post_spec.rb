require "rails_helper"

describe "Post Page", type: :request do
  let(:user) { create(:user) }
  describe "Unauthenticated user" do
    context "Index" do
      it "redirect to login page" do
        get "/posts"
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "New" do
      it "redirect to login page" do
        get "/posts/new"
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "Create" do
      let(:post_attributes) { attributes_for(:post) }
      it "redirect to login page" do
        post "/posts", params: { post: post_attributes }
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "Edit" do
      let(:post) { create(:post) }
      it "redirect to login page" do
        get "/posts/#{post.id}/edit"
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "Update" do
      let(:post) { create(:post) }
      let(:post_attributes) { attributes_for(:post) }
      it "redirect to login page" do
        put "/posts/#{post.id}", params: { post: post_attributes }
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "Show" do
      let(:post) { create(:post) }
      it "redirect to login page" do
        get "/posts/#{post.id}"
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "Delete" do
      let(:post) { create(:post) }
      it "redirect to login page" do
        delete "/posts/#{post.id}"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end