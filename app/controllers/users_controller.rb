class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    if signed_in?
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to my First RoR App!"
      redirect_to @user
    else
      render 'new'
    end
  end
end
