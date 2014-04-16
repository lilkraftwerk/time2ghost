class UsersController < ApplicationController
  include SessionHelper

  def show
    @user = current_user
    redirect_to root_path
  end

  def profile
    @user = current_user
    render :show
  end

  def new
    @user = User.new
  end

  def create
    params[:user][:phone_number].gsub!(/[^0-9]/, "")
    @user = User.new params[:user]
    if @user.save
      session[:user_id] = @user.id
      flash[:create] = "Account Created Successfully"
      redirect_to root_path
    else
      flash[:error] = "Account not created. Please try again."
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save
      redirect_to user_path, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

end
