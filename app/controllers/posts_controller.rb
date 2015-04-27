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
    end
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def set_scope
    @scope ||= params[:user_id] ? Post.where(author: params[:user_id]) : Post
  end

end
