class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:success] = "Your post has been shared"
      redirect_to @post
    else
      flash[:alert] = "Posts must have an image"
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated"
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  private

    def post_params
      params.require(:post).permit(:caption, :image)
    end

    def find_post
      @post = Post.find(params[:id])
    end

end
