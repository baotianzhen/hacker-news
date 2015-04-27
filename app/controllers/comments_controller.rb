class CommentsController < ApplicationController
  def index
    @comments = @scope.all
  end
  protected

  def set_scope
    @scope ||= params[:user_id] ? Comment.where(author: params[:user_id]) : Comment
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end


end
