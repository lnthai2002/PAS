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
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, notice: "#{@group.name} added"
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "#{@group.name} updated"
    else
      render :edit
    end
  end

  def destroy
    if !@group.users.exists? && @group.destroy
      redirect_to groups_path, notice: "#{@group.name} removed!"
    else
      redirect_to groups_path, alert: "#{@group.name} cannot be removed!"
    end
     
  end

protected

  def fetch_group
    @group = Group.find(params[:id])
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

  def group_params
    params.require(:group).permit(:name)
  end
end
