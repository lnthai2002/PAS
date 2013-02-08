class UsersController < ApplicationController
  before_filter :fetch_user, :only=>[:show, :edit, :update, :destroy]
  set_tab :account
  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path
    else
      render :save
    end
  end

protected

  def fetch_user
    @user = User.find(params[:id])
  end
end
