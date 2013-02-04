class StepsController < ApplicationController
  set_tab :cooking

  before_filter :find_recipe
  before_filter :find_step, :only => [:show, :edit, :update, :destroy]
=begin
  # GET /steps
  # GET /steps.json
  def index
    @steps = Step.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @steps }
    end
  end

  # GET /steps/1
  # GET /steps/1.json
  def show
    @step = Step.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @step }
    end
  end

  # GET /steps/new
  # GET /steps/new.json
  def new
    @step = @recipe.steps.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @step }
    end
  end
=end
  
  def edit
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = @recipe.steps.build(params[:step])

    if @step.save
      build_new_step
      render :update
    else
      
    end
  end

  # PUT /steps/1
  # PUT /steps/1.json
  def update
    if @step.update_attributes(params[:step])
      build_new_step
      render :update
    else
      
    end
    
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
#    @step = Step.find(params[:id])
    @step.destroy

    respond_to do |format|
      format.html { redirect_to @recipe }
      format.json { head :ok }
    end
  end

  def update_sequences
    begin
      Step.transaction  do #update all or nothing
        params[:recordid].each_with_index do |id, index|
          Step.update_all("sequence_number = #{index + 1}", ["id = ?", id])
        end
      end
    rescue Exception=>e
      notice = 'Cannot update sequence, there is something wrong, developer has been notified'
    end
    redirect_to :controller=>:recipes, :action=>:show, :id=>@recipe.id, :format => 'html'
  end

private
  def build_new_step
    #build a new step, this new one does not have sequence_id YET
    @step = @recipe.steps.build
  end

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
  
  def find_step
    @step = @recipe.steps.find(params[:id])
  end
end
