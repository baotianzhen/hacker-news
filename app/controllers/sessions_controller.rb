class SessionsController < ApplicationController
  def new
    @user = User.new
    render "new"
  end

  def create
    user = User.find_by_username(params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user_posts_path(user)
    else
      @errors = ["You have entered an invalid username/password"]
      render "new"
    end
  end

  def destroy
    session.clear
    redirect_to "root"
  end
end
