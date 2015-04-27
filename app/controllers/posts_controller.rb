class PostsController < ApplicationController
  before_action :set_scope, only: [:index]
  # before_action :set_scope, only: [:index, :edit, :show]


  def index
    @posts = @scope.all
    render "index"
  end

  def new
    if session[:user_id]
      @post = Post.new
      render "new"
    else
      @errors = ["You must be signed in to create a post"]
      redirect_to posts_path
    end
  end

  def create
    @post = Post.new(post_params)
    @user = User.find(session[:user_id])
    @user.posts << @post
    if @user.save
      redirect_to posts_path
    else
      @errors = @user.errors.full_messages
      render "new"
    end
  end

  def show
    @post = Post.find(post_params)
    render "show"
  end

  def edit
    @user = User.find(session[:user_id])
    @post = Post.find(params[:id])
    if @post.author.id == session[:user_id]
      render "edit"
    else
      @errors = ["You must be the author of the post to edit"]
      redirect_to :back
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_path(@post)
    else
      @errors = @post.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @post = Post.find(params[:id])
    @post.destroy if @user.id == @post.author.id
    redirect_to user_posts_path(@user)
  end

  protected

  def set_scope
    @scope ||= params[:user_id] ? Post.where(author: params[:user_id]) : Post
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
