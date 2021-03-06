class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post was created successfully"
    else
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update_attributes(post_params)
      redirect_to @post, notice: "Post was updated successfully"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was deleted successfully"
  end

  private

    def post_params
      params.require(:post).permit(:date, :rational, :status, :overtime_request)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
