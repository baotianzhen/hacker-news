class UsersController < ApplicationController
  def new
    @user = User.new
    render "new"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_posts_path(@user)
    else
      @errors = @user.errors.full_messages
      render "new"
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
    end
end
