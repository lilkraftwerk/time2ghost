class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = "Signup error."
      render :new
    end
  end
end