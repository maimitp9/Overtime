require "rails_helper"

describe "Post Page", type: :request do
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

  describe "Authenticated User" do
    let(:user) { create(:user) }
    before do
      sign_in(user)
    end

    context "Index" do
      let(:post) { build_stubbed(:post) }
      it "redirect to post index" do
        get "/posts"
        expect(response).to render_template(:index)
        expect(response.body).to include("Posts")
      end
    end

    context "New" do
      it "render new page" do
        get "/posts/new"
        expect(response).to render_template(:new)
        expect(response).to_not render_template(:show)
        expect(response.body).to include("New")
      end
    end

    context "Create" do
      let(:post_attributes) { attributes_for(:post, user: user) }
      it "create post and redirect to show" do
        post "/posts", params: { post: post_attributes }
        
        expect(response).to redirect_to(assigns(:post))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("Post was created successfully")
      end
    end

    describe "authorize user can edit and update" do
      let(:post) { create(:post, user: user) }

      context "Edit" do
        it "render edit page" do
          get "/posts/#{post.id}/edit"
          expect(response).to render_template(:edit)
          expect(response.body).to include("Edit")
          expect(response.body).to include(post.rational)
        end
      end

      context "Update" do
        let(:post_attributes) { attributes_for(:post) }
        it "update post and redirect to show page" do
          put "/posts/#{post.id}", params: { post: post_attributes }
          
          expect(response).to redirect_to(assigns(:post))
          follow_redirect!

          expect(response).to render_template(:show)
          expect(response.body).to include("Post was updated successfully")
        end
      end
    end

    describe "non authorize user can't edit or update" do
      let(:post) { create(:post) }

      context "Edit" do
        it "can't render edit page" do
          get "/posts/#{post.id}/edit"
          expect(response).to redirect_to root_path
        end
      end

      context "Update" do
        let(:post_attributes) { attributes_for(:post) }
        it "can't update post" do
          put "/posts/#{post.id}", params: { post: post_attributes }          
          expect(response).to redirect_to root_path
        end
      end
    end

    context "Show" do
      let(:post) { create(:post) }
      it "redirect to show page" do
        get "/posts/#{post.id}"
        expect(response).to render_template(:show)
        expect(response.body).to include(post.rational)
      end
    end

    context "Destroy" do
      let(:post) { create(:post) }
      it "delete post and redirect to index" do
        delete "/posts/#{post.id}"

        expect(response).to redirect_to posts_path
        expect(Post.find_by_id(post.id)).to eq(nil)
      end
    end
  end
end
