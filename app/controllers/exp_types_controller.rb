class ExpTypesController < ApplicationController
  #Service tab
  set_tab :financial
  #resource tab
  set_tab :all, :expense_types
  #action tab, each action tab correspond to one action, they belong to the namespace 'expense_type_acrtions'
  set_tab :list, :expense_type_actions, :only => %w(index)
  set_tab :add, :expense_type_actions, :only => %w(new)
  # GET /exp_types
  # GET /exp_types.json
  def index
    @exp_types = ExpType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exp_types }
    end
  end

  # GET /exp_types/1
  # GET /exp_types/1.json
  def show
    @exp_type = ExpType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exp_type }
    end
  end

  # GET /exp_types/new
  # GET /exp_types/new.json
  def new
    @exp_type = ExpType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exp_type }
    end
  end

  # GET /exp_types/1/edit
  def edit
    @exp_type = ExpType.find(params[:id])
  end

  # POST /exp_types
  # POST /exp_types.json
  def create
    @exp_type = ExpType.new(params[:exp_type])

    respond_to do |format|
      if @exp_type.save
        format.html { redirect_to exp_types_path, notice: 'Exp type was successfully created.' }
        format.json { render json: @exp_type, status: :created, location: @exp_type }
      else
        format.html { render action: "new" }
        format.json { render json: @exp_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exp_types/1
  # PUT /exp_types/1.json
  def update
    @exp_type = ExpType.find(params[:id])

    respond_to do |format|
      if @exp_type.update_attributes(params[:exp_type])
        format.html { redirect_to @exp_type, notice: 'Exp type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @exp_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exp_types/1
  # DELETE /exp_types/1.json
  def destroy
    @exp_type = ExpType.find(params[:id])
    @exp_type.destroy

    respond_to do |format|
      format.html { redirect_to exp_types_url }
      format.json { head :ok }
    end
  end
end