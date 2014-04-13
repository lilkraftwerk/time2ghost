class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    @user = User.new
  end

  def create
    user = User.create params[:user]
    # @user = User.new
    # @user.username = params[:user][:username]
    # @user.password = params[:user][:password]
    # @user.password_confirmation = params[:user][:password]
    if user.valid?
      session[:user_id] = user.id
      flash[:create] = "Account Created Successfully"
      redirect_to root_path
    else
      flash[:error] = "Account not created. Please try again."
      render :new
    end
  end



end
