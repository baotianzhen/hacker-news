class CommentsController < ApplicationController
    before_action :set_scope, only: [:index]
    before_action :set_commentable, only: [:new, :create]

  def index
    @comments = @scope.all
  end

  def new
    if session[:user_id]
      #@commentable
      @comment = Comment.new
    else
      @errors = ["You must be signed in to comment on a post"]
      redirect_to posts_path
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @user = User.find_by(id: session[:user_id])

    if @commentable.comments << @comment && @user.comments << @comment
      redirect_to posts_path #switch
    else
      @errors = @comment.errors.full_messages
      render "new"
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @comment = @comment.find_by(id: params[:id])
    if @comment.author.id == session[:user_id]
      render "edit"
    else
      @errors = ["You must be the author of the comment to edit"]
      redirect_to :back
    end
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update_attributes(comment_params)
      redirect_to @comment
    else
      @errors = @comment.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @user = User.find_by(id: session[:user_id])
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy if @user.id == @post.author.id
    redirect_to user_posts_path(@user)
  end

  protected

  def set_scope
    @scope ||= params[:user_id] ? Comment.where(author: params[:user_id]) : Comment
  end

  def set_commentable
    @commentable =  if params[:post_id]
                      Post.find_by(id: params[:post_id])
                    else
                      Comment.find_by(id: params[:comment_id])
                    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end


end
