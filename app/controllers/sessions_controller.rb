class SessionsController < ApplicationController

  def create
    user = User.find_by_username(params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "Login Unsuccessful. Please try again."
      redirect_to root_path
    end
  end

  def delete
  end

end
