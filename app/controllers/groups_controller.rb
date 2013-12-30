class GroupsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :authorize_user
  before_filter :fetch_group, :only=>[:show, :edit, :update, :destroy]
  def index
    @groups = Group.all
  end

  def show
    
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @group.update_attributes(params[:group])
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

protected

  def fetch_group
    @group = Group.find(params[:id])
  end

  def authorize_user
    user = User.where(:email=>session[:cas_user]).first
    if user.blank? || user.groups.where(:name=>'admin').all.blank?
      render :file => "public/401.html", :status => :unauthorized
    end
  end
end
