class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post, notice: "Post was created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
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
      params.require(:post).permit(:date, :rational)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
