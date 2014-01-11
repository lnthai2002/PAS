class UsersController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :authorize_user
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
    if @user.update(user_params)
      redirect_to users_path, notice: "#{@user.email} updated"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: "#{@user.email} removed from authentication service"
    else
      redirect_to users_path, alert: "#{@user.email} cannot be removed!"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "#{@user.email} added!"
    else
      render :new
    end
  end

protected

  def fetch_user
    @user = User.find(params[:id])
  end

  def authorize_user
    if !User.joins(:groups)
            .where('email'=>session[:cas_user],
                   'groups.name'=>'admin')
            .exists?
      render :file => "public/401.html", :status => :unauthorized
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
